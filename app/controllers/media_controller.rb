class MediaController < ApplicationController
  before_filter :set_mediable, only: [:new, :create]

  def new
    @media = @mediable.medias.build
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
    @media = @mediable.medias.build(media_params)
    @media.save
  end

  private
    def media_params
      params[:media].permit(:url, :publish_date, :mediable_id, :title)
    end
  
    def set_mediable
      param = params.keys.find{|key| key =~ /(\w+)_id/}
      @mediable = $1.capitalize.constantize.find(params[param])
    end

end