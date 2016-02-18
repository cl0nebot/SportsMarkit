class RegistrationsController < ApplicationController
  before_action :find_object, only: [:new]
  
  
  def new
    @team = Team.find(params[:team_id])
    @form = @team.forms.first
    @master = Form.where(submittable_type: "User", submittable_id: current_user.id, master: true).last
  end
  
  def register
    @form_id = params[:registration_id]
    @form = Form.find(@form_id)
  end
  
  def create
    @form = Form.new(form_params)
    unless Form.where(submittable_type: params[:submittable_type], submittable_id: params[:submittable_id], master: true).present?
      @master = Form.new(form_params)
      @master.master = true
      @master.save
    end 
    if @form.save
      SelectedOption.create(user_id:  params[:submittable_id], form_id: @form.id, option_id: params[:registration_options])
      redirect_to "/#{@form.formable_type.underscore.pluralize}/#{@form.formable.slug}/registrations/#{@form.id}/register"
    else
      render "didn't save"
    end
  end
  
  def change_submitter
    @form = Form.find(params[:form_id])
    @master = Form.where(submittable_type: "User", submittable_id: params[:user_id], master: true).last
    @submitter = User.find(params[:user_id])
    @object = params[:object_type].constantize.find(params[:object_id])
  end
  
  def pay
    stripe_token = params[:form][:stripe_token]
    begin

      raise "Stripe token not present. Cannot process transaction." if stripe_token.blank?
      
    end
     
    render text: params
  end
  
  
  def form_params
    params.require(:form).permit(:submittable_id, :submittable_type, :submitter_id, :formable_type, :formable_id, :object, :section_1, :form_name, :form_description, :section_2, :first_name, :middle_name, :last_name, :prefix, :suffix, :date_of_birth, :mobile_phone_number, :home_phone_number, :sex, :address, :ethnicity, :lives_with, :t_shirt_size, :section_3, :membership_status, :membership_status_options, :section_4, :allergies, :medical_conditions, :medications, :section_5, :school_name, :school_district, :section_6, :guardian_1_name, :guardian_1_relationship, :guardian_1_address, :guardian_1_phone, :guardian_1_email, :guardian_2_name, :guardian_2_relationship, :guardian_2_address, :guardian_2_phone, :guardian_2_email, :section_7, :emergency_1_name, :emergency_1_relationship, :emergency_1_address, :emergency_1_phone, :emergency_1_email, :emergency_2_name, :emergency_2_relationship, :emergency_2_address, :emergency_2_phone, :emergency_2_email, :section_8, :insurance_company, :insurance_policy_number, :insurance_group_number, :employer_insurance, :employer_name, :section_9, :special_assistance_programs, :annual_family_income, :number_in_household, :section_10, :waiver, :accept_waiver, :agreements, :first_name_required, :middle_name_required, :last_name_required, :prefix_required, :suffix_required, :date_of_birth_required, :mobile_phone_number_required, :home_phone_number_required, :sex_required, :address_required, :ethnicity_required, :lives_with_required, :t_shirt_size_required, :membership_status_required, :allergies_required, :medical_conditions_required, :medications_required, :school_name_required, :school_district_required, :guardian_1_name_required, :guardian_1_relationship_required, :guardian_1_address_required, :guardian_1_phone_required, :guardian_1_email_required, :guardian_2_name_required, :guardian_2_relationship_required, :guardian_2_address_required, :guardian_2_phone_required, :guardian_2_email_required, :emergency_1_name_required, :emergency_1_relationship_required, :emergency_1_address_required, :emergency_1_phone_required, :emergency_1_email_required, :emergency_2_name_required, :emergency_2_relationship_required, :emergency_2_address_required, :emergency_2_phone_required, :emergency_2_email_required, :insurance_company_required, :insurance_policy_number_required, :insurance_group_number_required, :employer_insurance_required, :employer_name_required, :special_assistance_programs_required, :annual_family_income_required, :number_in_household_required, :first_name_display, :middle_name_display, :last_name_display, :prefix_display, :suffix_display, :date_of_birth_display, :mobile_phone_number_display, :home_phone_number_display, :sex_display, :address_display, :ethnicity_display, :lives_with_display, :t_shirt_size_display, :membership_status_display, :allergies_display, :medical_conditions_display, :medications_display, :school_name_display, :school_district_display, :guardian_1_name_display, :guardian_1_relationship_display, :guardian_1_address_display, :guardian_1_phone_display, :guardian_1_email_display, :guardian_2_name_display, :guardian_2_relationship_display, :guardian_2_address_display, :guardian_2_phone_display, :guardian_2_email_display, :emergency_1_name_display, :emergency_1_relationship_display, :emergency_1_address_display, :emergency_1_phone_display, :emergency_1_email_display, :emergency_2_name_display, :emergency_2_relationship_display, :emergency_2_address_display, :emergency_2_phone_display, :emergency_2_email_display, :insurance_company_display, :insurance_policy_number_display, :insurance_group_number_display, :employer_insurance_display, :employer_name_display, :special_assistance_programs_display, :annual_family_income_display, :number_in_household_display)
  end
  
  def find_object
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @object = $1.capitalize.constantize.find(params[param])
  end
  
end
