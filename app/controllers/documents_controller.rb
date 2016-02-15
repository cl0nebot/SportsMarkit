class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :find_documentable, except: %w[destroy]
  before_action :find_document, only: %w[edit update]

  def index
    @documents = Document.where(documentable_id: @object.id, documentable_type: @object.class.to_s)
    @document = @object.documents.build
  end

  def create
    document = @object.documents.build(document_params)
    if document.save
      flash.now[:success] = "Document has been created."
    else
      flash.now[:error] = document.errors.full_messages
    end
    @documents = Document.where(documentable_id: @object.id, documentable_type: @object.class.to_s)
    respond_to do |format|
      format.html{redirect_to :back}
      format.js
    end
  end

  def update
    result = @document.update_attributes(document_params)
    if result
      flash.now[:success] = "Document has been updated."
    else
      flash.now[:error] = @document.errors.full_messages
    end
    @documents = Document.where(documentable_id: @object.id, documentable_type: @object.class.to_s)
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end

  def destroy
    document = Document.where(id: params[:id]).first
    @index = document.id
    if document.destroy
      flash.now[:success] = "Document has been deleted."
    else
      flash.now[:success] = "Unable to delete Document."
    end
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end

  private
    def find_documentable
      param = params.keys.find{|key| key =~ /(\w+)_id/}
      @object = $1.capitalize.constantize.find(params[param])
    end

    def find_document
      @document = @object.documents.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:file, :description, :name)
    end
end
