class MediaController < ApplicationController
  before_action :set_mediable, only: :new

  def new
    @media = Media.new
  end

  def destroy
    @media = Media.find(params[:id])
    @media.destroy
  end

  def update
    @media = Media.find(params[:id])
    @media.update(media_params)
    render nothing: true
  end

  def create
    @media = Media.new(media_params
    @media.save
    @mediable = @media.mediable
  end

  private
    def media_params
      params[:media].permit(:url, :publish_date, :mediable_id, :title, :category, :mediable_type)
    end
  
    def set_mediable
      param = params.keys.find{|key| key =~ /(\w+)_id/}
      @mediable = $1.capitalize.constantize.find(params[param])
    end

end