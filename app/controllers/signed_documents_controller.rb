class SignedDocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :find_documentable
  before_action :find_document, only: %w[new create]

  def index
    documents = Document.where(documentable_id: @object.id, documentable_type: @object.class.to_s)
    @signed_documents = SignedDocument.where(document_id: documents)
  end

  def create
    signed_doc = SignedDocument.where(user_id: current_user.id, document_id: @document.id, signed: true).first
    if signed_doc.present?
      flash[:error] = "Document already signed."
      redirect_to :back
    else
      if @document.present?
        doc_url = open(@document.try(:file).try(:url))
        custom_path = "#{request.protocol}#{request.host}:#{request.port}/documents/#{@document.id}/signed_documents/new?path=#{params[:path]}"
        name = "#{current_user.first_name} #{current_user.last_name}"
        begin
          client = DocusignRest::Client.new
          @envelope_response = client.create_envelope_from_document(
            email: {
              subject: "Test Document",
              body: "Please sign the document, put anything here."
            },
            signers: [
              {
                embedded: true,
                name: name,
                email: current_user.email
              }
            ],
            files: [
              { path: doc_url }
            ],
            status: 'sent'
          )

          response = client.get_recipient_view(
            envelope_id: @envelope_response["envelopeId"],
            name: name,
            email: current_user.email,
            return_url: custom_path
          )
          redirect_to response["url"]
        rescue
          flash[:error] = "Document file not found."
          redirect_to :back
        end
      else
        flash[:error] = "Document not found."
        redirect_to :back
      end
    end
  end

  def new
    if params[:event] == "signing_complete"
      signed_doc = SignedDocument.where(user_id: current_user.id, document_id: @document.id, signed: false).first
      if signed_doc.present?
        signed_doc.update(signed: true)
      else
        SignedDocument.create!(user_id: current_user.id, document_id: @document.id, signed: true)
      end
      flash[:success] = "Thanks! Successfully signed"
    else
      SignedDocument.create!(user_id: current_user.id, document_id: @document.id, signed: false)
      flash[:error] = "Document not signed."
    end
    if params[:path].present?
      path = "#{request.protocol}#{request.host}:#{request.port}#{params[:path]}"
    else
      path = root_path
    end
    redirect_to path
  end

  private
    def find_documentable
      param = params.keys.find{|key| key =~ /(\w+)_id/}
      @object = $1.capitalize.constantize.find(params[param])
    end

    def find_document
      @document = Document.where(id: params[:document_id]).first
    end
end
