class RegistrationsController < ApplicationController
  before_action :load_form, only: [:registrant, :register, :change_submitter, :pay]
  before_action :load_master, only: [:change_submitter], :if => :current_user?
  before_action :load_object, only: [:new, :register, :registrant, :index, :pay_manual]
  before_action :load_registrants, only: [:index, :pay_manual]
 # before_filter :load_and_restrict_registration, only: [:new]

  def index
  end

  def new
    #@form defined in load_and_restrict_registration method
    @master = current_user? ? Form.where(submittable_type: "User", submittable_id: current_user.id, master: true).last : Form.new
  end

  def load_and_restrict_registration
    @form = @object.forms.where(master: true).first
    restrictor = Restrictors::Registration.call(form: @form, preview: params[:preview], launch: params[:launch])
    if restrictor.failure?
      flash[:error] = restrictor.error
      redirect_to_back(url_for(@object))
    end
  end

  def register
  end

  def registrant
  end

  def create
    @form = Form.find_or_create_by(formable_id: params[:form][:formable_id], formable_type: params[:form][:formable_type], object: params[:object], submittable_id: params[:form][:submittable_id], submittable_type: params[:form][:submittable_type] )
    @form.update_attributes(form_params)
    @form.select_pricing_option(@form.id, params)
    if @form.selected_option.option.price.zero?
      @form.pay!
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
      @form.pay!
    end
    #redirect_to eval("#{@form.formable.class.to_s.underscore}_registrations_path(@form.formable)")
    redirect_to user_registrations_path(@form.submitter_id)
  end

  def pay_manual
    Form.find(params[:id]).pay!('manual')
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
