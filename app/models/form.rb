class Form < ActiveRecord::Base
  belongs_to :formable, polymorphic: true
  
  attr_accessor :stripe_token
  
  
  def self.general_fields
    [["Prefix", "prefix"],["First Name", "first_name"], ["Middle Name", "middle_name"], ["Last Name", "last_name"], ["Suffix", "suffix"], ["Date of Birth", "date_of_birth"],["Mobile Phone Number", "mobile_phone_number"],["Home Phone Number", "home_phone_number"]]
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
  
  
  
  
  
  
end


