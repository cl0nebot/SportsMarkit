class MeasurablesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @measure = @user.measurables.build
  end

  def destroy
    @measure = Measurable.find(params[:id])
    @measure.destroy
  end

  def update
    @measure = Measurable.find(params[:id])
    @measure.update(measurable_params)
    render nothing: true
  end

  def create
    @user = User.find(params[:user_id])
    @measure = @user.measurables.build(measurable_params)
    @measure.save
  end
  
  def verify
    @measurable = Measurable.find(params[:measurable_id])
    @object = User.find(@measurable.user_id)
    @measurable.update_attributes(verified: true)
    respond_to do |format|
      format.html{redirect_to :back}
      format.js
    end
  end

  private
    def measurable_params
      params[:measurable].permit(:sport, :measurable, :result, :user_id)
    end
end