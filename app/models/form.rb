class Form < ActiveRecord::Base
  belongs_to :formable, polymorphic: true
  belongs_to :submittable, polymorphic: true
  belongs_to :submitter, class_name: "User", foreign_key: "submitter_id"
  has_many :options
  has_one :selected_option

  attr_accessor :stripe_token

  def self.general_fields
    [["Prefix", "prefix"],["First Name", "first_name"], ["Middle Name", "middle_name"], ["Last Name", "last_name"], ["Suffix", "suffix"], ["Date of Birth", "date_of_birth"],["Mobile Phone Number", "mobile_phone_number"],["Home Phone Number", "home_phone_number"], ["Ethnicity", "ethnicity"], ["Lives With", "lives_with"]]
  end

  def self.guardian_fields
    [["Guardian Name", "guardian_1_name"], ["Guardian Relationship To Athlete", "guardian_1_relationship"], ["Guardian Address", "guardian_1_address"], ["Guardian Phone", "guardian_1_phone"], ["Guardian Email", "guardian_1_email"], ["Secondary Guardian Name", "guardian_2_name"], ["Secondary Guardian Relationship To Athlete", "guardian_2_relationship"], ["Secondary Guardian Address", "guardian_2_address"], ["Secondary Guardian Phone", "guardian_2_phone"], ["Secondary Guardian Email", "guardian_2_email"]]
  end

  def self.emergency_fields
    [["Emergency Name", "emergency_1_name"], ["Emergency Relationship To Athlete", "emergency_1_relationship"], ["Emergency Address", "emergency_1_address"], ["Emergency Phone", "emergency_1_phone"], ["Emergency Email", "emergency_1_email"], ["Secondary Emergency Name", "emergency_2_name"], ["Secondary Emergency Relationship To Athlete", "emergency_2_relationship"], ["Secondary Emergency Address", "emergency_2_address"], ["Secondary Emergency Phone", "emergency_2_phone"], ["Secondary Emergency Email", "emergency_2_email"]]
  end

  def self.insurance_fields
    [["Insurance Company", "insurance_company"], ["Insurance Policy Number", "insurance_policy_number"], ["Insurance Group Number", "insurance_group_number"], ["Employer Insurance", "employer_insurance"], ["Employer Name", "employer_name"]]
  end

  def self.health_fields
    [["Allergies", "allergies"], ["Medical Conditions", "medical_conditions"], ["Medications", "medications"]]
  end


  def self.membership_fields
    [["Membership", "membership_status"]]
  end

  def self.school_fields
    [["School Name", "school_name"],["School District", "school_district"]]
  end

  def self.financial_fields
    [["Special Assistance Programs", "special_assistance_programs"], ["Annual Family Income", "annual_family_income"], ["Number in Household", "number_in_household"]]
  end

  def general_fields?
    array =[]
    Form.general_fields.each do |field|
      array << send("#{field.last}_display?")
      array << send("#{field.last}_required?")
    end
    array.include? true
  end

  def guardian_fields?
    array =[]
    Form.guardian_fields.each do |field|
      array << send("#{field.last}_display?")
      array << send("#{field.last}_required?")
    end
    array.include? true
  end

  def emergency_fields?
    array =[]
    Form.emergency_fields.each do |field|
      array << send("#{field.last}_display?")
      array << send("#{field.last}_required?")
    end
    array.include? true
  end

  def insurance_fields?
    array =[]
    Form.insurance_fields.each do |field|
      array << send("#{field.last}_display?")
      array << send("#{field.last}_required?")
    end
    array.include? true
  end

  def health_fields?
    array =[]
    Form.health_fields.each do |field|
      array << send("#{field.last}_display?")
      array << send("#{field.last}_required?")
    end
    array.include? true
  end

  def membership_fields?
    array =[]
    Form.membership_fields.each do |field|
      array << send("#{field.last}_display?")
      array << send("#{field.last}_required?")
    end
    array.include? true
  end

  def school_fields?
    array =[]
    Form.school_fields.each do |field|
      array << send("#{field.last}_display?")
      array << send("#{field.last}_required?")
    end
    array.include? true
  end


  def financial_fields?
    array =[]
    Form.financial_fields.each do |field|
      array << send("#{field.last}_display?")
      array << send("#{field.last}_required?")
    end
    array.include? true
  end

  def create_master(params={}, form_params)
    master_form = Form.where(submittable_type: params[:submittable_type], submittable_id: params[:submittable_id], master: true).last
    if !master_form.present?
      master = Form.new(submittable_type: params[:submittable_type], submittable_id: params[:submittable_id], master: true)
      master.save
    else
      master_form.update_attributes(form_params)
      master_form.update_attributes(formable_type: nil, formable_id: nil, master: true)
    end
    master_form
  end

  def registrant
    submittable
  end

  def select_pricing_option(id, params={})
    selected_option = SelectedOption.find_or_create_by(user_id:  params[:form][:submittable_id], form_id: id)
    selected_option.update_attributes(option_id: params[:registration_options])
  end

  def button_styling(field_name)
    field = field_name
    display_field = "#{field_name}_display"
    required_field = "#{field_name}_required"
    if self.send(required_field) == true
      button_style = "btn btn-danger"
    elsif self.send(display_field) == true
      button_style = "btn btn-success"
    else
      button_style = "btn btn"
    end
  end

  def get_data
    (data.try(:[], 'fields').try(:values) || {}).to_json
  end
end
