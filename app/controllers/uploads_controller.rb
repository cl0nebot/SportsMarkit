class UploadsController < ApplicationController
  before_action :find_object, only: [:index]

  def index
  end

  def create
    model = params[:object].constantize
    importer = "Importer::#{params[:importer]}".constantize

    if model == Team
      @import = importer.call(file: params[:file], team_id: Team.find(params[:team_id]).id)
    elsif [School, Club].include?(model)
      @import = importer.call(file: params[:file], teamable: model.find(params[:teamable_id]))
    end

    if @import.failure?
      if @import.error_xls
        file = Tempfile.new(["import-error"], Rails.root.join("tmp"))
        file.binmode
        file.write(@import.error_xls.read)
        file.close
        redirect_to :back, flash: { alert: @import.errors, file_with_errors_path: file.path }
      else
        redirect_to :back, flash: { alert: @import.errors }
      end
    else
      redirect_to :back, notice: 'Uploaded'
    end
  end

  def download_errors
    file = open(params[:path])
    send_data(file.read, type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', filename: "import-error-#{Time.now}.xlsx")
  end

  def find_object
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @object = $1.capitalize.constantize.find(params[param])
  end
end
