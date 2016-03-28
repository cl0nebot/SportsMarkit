class UploadsController < ApplicationController
  before_action :find_object, only: [:index]
  
  def index
    
  end
  
  def create
    model = params[:object].constantize
    importer = "Importer::#{params[:importer]}".constantize

    if model == Team
      @import = importer.call(file: params[:file], team_id: params[:team_id])
    elsif [School, Club].include?(model)
      @import = importer.call(file: params[:file], teamable: model.find(params[:teamable_id]))
    end

    if @import.failure?
      if @import.error_xls
        send_data(@import.error_xls.read, type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', filename: "import-error-#{Time.now}.xlsx")
        return
      end
    else
      redirect_to :back, notice: 'Uploaded'
    end
  end

  def find_object
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @object = $1.capitalize.constantize.find(params[param])
  end
end


# class UploadsController < ApplicationController
#   before_action :find_object, only: [:index]
#
#   def index
#
#   end
#
#   def import
#     model = params[:object].constantize
#     if params[:school_id].present?
#       model.import_team(params[:file], params[:school_id])
#     else
#       model.import(params[:file], model)
#     end
#     redirect_to :back, notice: "Uploaded."
#   end
#
#   def roster
#     model = params[:object].constantize
#     if params[:team_id].present?
#       model.import_team(params[:file], params[:team_id])
#     else
#     end
#     redirect_to :back, notice: "Uploaded."
#   end
#
#   private
#
#   def find_object
#     param = params.keys.find{|key| key =~ /(\w+)_id/}
#     @object = $1.capitalize.constantize.find(params[param])
#   end
#
# end
