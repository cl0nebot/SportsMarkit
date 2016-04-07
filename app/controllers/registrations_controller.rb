class RegistrationsController < ApplicationController
  before_action :load_form, only: [:registrant, :register, :change_submitter, :pay]
  before_action :load_master, only: [:change_submitter], :if => :current_user?


  def new
    load_object
    @form = @object.forms.first
    @master = current_user? ? Form.where(submittable_type: "User", submittable_id: current_user.id, master: true).last : Form.new
  end

  def register
    load_object
  end

  def registrant
    load_object
  end

  def create
    Form.create_master(params, form_params)
    @form = Form.find_or_create_by(formable_id: params[:form][:formable_id], formable_type: params[:form][:formable_type], object: params[:object], submittable_id: params[:form][:submittable_id], submittable_type: params[:form][:submittable_type] )
    @form.update_attributes(form_params)
    @form.select_pricing_option(@form.id, params)
    redirect_to "/#{@form.formable_type.underscore.pluralize}/#{@form.formable.slug}/registrations/#{@form.id}/register"
  end

  def change_submitter
    @submitter = User.find(params[:user_id])
    @object = params[:object_type].constantize.find(params[:object_id])
  end

  def pay
    stripe_token = params[:stripe_token]
    amount = params[:amount].to_i * 100

    begin
      raise "Stripe token not present. Cannot process transaction." if stripe_token.blank?
      current_user.process_transaction(params, amount)

      @form.update_attributes(paid: true)
    end
    redirect_to eval("#{@form.formable.class.to_s.underscore}_registrations_path(@form.formable)")
  end

  def form_params
    params.require(:form).permit!.merge(user_data: params.require(:user_data).permit!.as_json)
  end

  def index
    load_object
    load_registrants
  end

  private

  def load_registrants
    @registrations = Form.where(formable_type: @object.class.to_s, formable_id: @object.id).where.not(submittable_type: nil, submittable_id: nil)
  end

  def load_object
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @object = $1.capitalize.constantize.find(params[param])
  end

  def load_form
    @form = Form.find(params[:registration_id] || params[:form_id])
  end

  def load_master
    @master = Form.where(submittable_type: "User", submittable_id: params[:user_id], master: true).last
  end

  def current_user?
    current_user.present?
  end
end
