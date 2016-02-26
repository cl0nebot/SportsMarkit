class SignedDocuments2Controller < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :find_documentable

  def index
    documents = Document.where(documentable_id: @object.id, documentable_type: @object.class.to_s)
    @signed_documents = SignedDocument.where(document_id: documents)
  end

  private
    def find_documentable
      param = params.keys.find{|key| key =~ /(\w+)_id/}
      @object = $1.capitalize.constantize.find(params[param])
    end
end
