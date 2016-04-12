class OptionsController < ApplicationController

  def index
    @form = Form.find(params[:form_id])
    @option = Option.new
  end

  def new
    @form = Form.find(params[:form_id])
    @option = @form.options.build
  end

  def create
    @form = Form.find(params[:form_id])
    @option = @form.options.build(option_params)
    @option.save
  end

  def update
    @option = Option.find(params[:id])
    @option.update_attributes(option_params)
  end

  def destroy
    @option = Option.find(params[:id])
    @option.destroy
  end

  protected

  def option_params
    params.require(:option).permit(:name, :description, :object, :form_id, :price)
  end
end
