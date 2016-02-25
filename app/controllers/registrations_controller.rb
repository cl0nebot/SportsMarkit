class RegistrationsController < ApplicationController
  before_action :load_form, only: [:register, :change_submitter, :pay]
  before_action :load_master, only: [:change_submitter]
  
  
  def new
    load_object
    @form = @object.forms.first
    @master = Form.where(submittable_type: "User", submittable_id: current_user.id, master: true).last
  end
  
  def register
    load_object
  end
  
  def create
    Form.new.create_master(params, form_params)
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
    stripe_token = params[:form][:stripe_token]
    @form.update_attributes(paid: true)
    redirect_to eval("#{@form.formable.class.to_s.underscore}_registrations_path(@form.formable)")
  end
  
  def form_params
    params.require(:form).permit(:submittable_id, :submittable_type, :submitter_id, :formable_type, :formable_id, :object, :section_1, :form_name, :form_description, :section_2, :first_name, :middle_name, :last_name, :prefix, :suffix, :date_of_birth, :mobile_phone_number, :home_phone_number, :sex, :address, :ethnicity, :lives_with, :t_shirt_size, :section_3, :membership_status, :membership_status_options, :section_4, :allergies, :medical_conditions, :medications, :section_5, :school_name, :school_district, :section_6, :guardian_1_name, :guardian_1_relationship, :guardian_1_address, :guardian_1_phone, :guardian_1_email, :guardian_2_name, :guardian_2_relationship, :guardian_2_address, :guardian_2_phone, :guardian_2_email, :section_7, :emergency_1_name, :emergency_1_relationship, :emergency_1_address, :emergency_1_phone, :emergency_1_email, :emergency_2_name, :emergency_2_relationship, :emergency_2_address, :emergency_2_phone, :emergency_2_email, :section_8, :insurance_company, :insurance_policy_number, :insurance_group_number, :employer_insurance, :employer_name, :section_9, :special_assistance_programs, :annual_family_income, :number_in_household, :section_10, :waiver, :accept_waiver, :agreements, :first_name_required, :middle_name_required, :last_name_required, :prefix_required, :suffix_required, :date_of_birth_required, :mobile_phone_number_required, :home_phone_number_required, :sex_required, :address_required, :ethnicity_required, :lives_with_required, :t_shirt_size_required, :membership_status_required, :allergies_required, :medical_conditions_required, :medications_required, :school_name_required, :school_district_required, :guardian_1_name_required, :guardian_1_relationship_required, :guardian_1_address_required, :guardian_1_phone_required, :guardian_1_email_required, :guardian_2_name_required, :guardian_2_relationship_required, :guardian_2_address_required, :guardian_2_phone_required, :guardian_2_email_required, :emergency_1_name_required, :emergency_1_relationship_required, :emergency_1_address_required, :emergency_1_phone_required, :emergency_1_email_required, :emergency_2_name_required, :emergency_2_relationship_required, :emergency_2_address_required, :emergency_2_phone_required, :emergency_2_email_required, :insurance_company_required, :insurance_policy_number_required, :insurance_group_number_required, :employer_insurance_required, :employer_name_required, :special_assistance_programs_required, :annual_family_income_required, :number_in_household_required, :first_name_display, :middle_name_display, :last_name_display, :prefix_display, :suffix_display, :date_of_birth_display, :mobile_phone_number_display, :home_phone_number_display, :sex_display, :address_display, :ethnicity_display, :lives_with_display, :t_shirt_size_display, :membership_status_display, :allergies_display, :medical_conditions_display, :medications_display, :school_name_display, :school_district_display, :guardian_1_name_display, :guardian_1_relationship_display, :guardian_1_address_display, :guardian_1_phone_display, :guardian_1_email_display, :guardian_2_name_display, :guardian_2_relationship_display, :guardian_2_address_display, :guardian_2_phone_display, :guardian_2_email_display, :emergency_1_name_display, :emergency_1_relationship_display, :emergency_1_address_display, :emergency_1_phone_display, :emergency_1_email_display, :emergency_2_name_display, :emergency_2_relationship_display, :emergency_2_address_display, :emergency_2_phone_display, :emergency_2_email_display, :insurance_company_display, :insurance_policy_number_display, :insurance_group_number_display, :employer_insurance_display, :employer_name_display, :special_assistance_programs_display, :annual_family_income_display, :number_in_household_display)
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
    
  # def save_registration
  #   if @form.save
  #     @form.select_pricing_option(@form.id, params)
  #     redirect_to "/#{@form.formable_type.underscore.pluralize}/#{@form.formable.slug}/registrations/#{@form.id}/register"
  #   end
  # end
  
  def load_master
    @master = Form.where(submittable_type: "User", submittable_id: params[:user_id], master: true).last
  end
  
    
  
end
