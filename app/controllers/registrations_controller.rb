class RegistrationsController < ApplicationController
  before_action :load_form, only: [:registrant, :register, :change_submitter, :pay]
  before_action :load_master, only: [:change_submitter], :if => :current_user?
  before_action :load_object, only: [:new, :register, :registrant, :index, :pay_manual]
  before_action :load_registrants, only: [:index, :pay_manual]

  def index
  end

  def new
    @form = @object.forms.where(master: true).first
    @master = current_user? ? Form.where(submittable_type: "User", submittable_id: current_user.id, master: true).last : Form.new
    redirect_to url_for(@object) if !@form.try(:options).present? && !params[:preview].present?
  end

  def register
  end

  def registrant
  end

  def create
    @form = Form.find_or_create_by(formable_id: params[:form][:formable_id], formable_type: params[:form][:formable_type], object: params[:object], submittable_id: params[:form][:submittable_id], submittable_type: params[:form][:submittable_type] )
    SendEmail.new_registration(master_form.submitter, @form.submitter).deliver if Form.master_form(form_params).notify_creator
    @form.update_attributes(form_params)
    @form.select_pricing_option(@form.id, params)
    if @form.selected_option.option.price.zero?
      @form.update_attribute(:paid, true)
      #redirect_to url_for([@form.formable, :registrations])
      redirect_to user_registrations_path(params[:form][:submittable_id])
    else
      redirect_to "/#{@form.formable_type.underscore.pluralize}/#{@form.formable.slug}/registrations/#{@form.id}/register"
    end
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

  def pay_manual
    registrant = Form.find(params[:id])
    registrant.update(params.permit(:paid, :payment_type))
  end

  private

  def form_params
    params.require(:form).permit!.merge(user_data: params.require(:user_data).permit!.as_json)
  end

  def load_registrants
    @registrations = Form.where(formable: @object).where.not(submittable_type: nil, submittable_id: nil).where(master: nil)
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
