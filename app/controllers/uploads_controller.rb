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
      binding.pry
      redirect_to :back, alert: @import.errors
    else
      redirect_to :back, notice: 'Uploaded'
    end
  end

  def find_object
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @object = $1.capitalize.constantize.find(params[param])
  end
end
