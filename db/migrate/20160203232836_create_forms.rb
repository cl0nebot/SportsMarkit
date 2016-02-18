class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
     
      t.string :formable_type
      t.integer :formable_id
      
      t.string :submittable_type
      t.integer :submittable_id
      t.integer :submitter_id

      # form details
      t.string :section_1
      t.string :form_name
      t.text :form_description
      t.string :object

      # registrant
      t.string :section_2
      t.string :first_name, :limit => 30
      t.string :middle_name, :limit => 30
      t.string :last_name, :limit => 30
      t.string :prefix, :limit => 10
      t.string :suffix, :limit => 15
      t.date :date_of_birth
      t.string :mobile_phone_number, :limit => 20
      t.string :home_phone_number, :limit => 20
      t.string :sex, :limit => 10
      t.text :address
      #ethnicity
      t.string :ethnicity
      t.string :lives_with
      t.string :t_shirt_size, :limit => 15

      #membership
      t.string :section_3, :limit => 30
      t.string :membership_status
      t.string :membership_status_options

      #health
      t.string :section_4, :limit => 30
      t.text :allergies
      t.text :medical_conditions
      t.text :medications
 
      # school
      t.string :section_5, :limit => 30
      t.string :school_name
      t.string :school_district

      # guardian
      t.string :section_6, :limit => 30
      t.string :guardian_1_name
      t.string :guardian_1_relationship
      t.string :guardian_1_address
      t.string :guardian_1_phone
      t.string :guardian_1_email
      # guardian
      t.string :guardian_2_name
      t.string :guardian_2_relationship
      t.string :guardian_2_address
      t.string :guardian_2_phone
      t.string :guardian_2_email

      # emergency
      t.string :section_7, :limit => 30
      t.string :emergency_1_name
      t.string :emergency_1_relationship
      t.string :emergency_1_address
      t.string :emergency_1_phone
      t.string :emergency_1_email

      t.string :emergency_2_name
      t.string :emergency_2_relationship
      t.string :emergency_2_address
      t.string :emergency_2_phone
      t.string :emergency_2_email


      # insurance
      t.string :section_8, :limit => 30
      t.string :insurance_company
      t.string :insurance_policy_number
      t.string :insurance_group_number
      t.boolean :employer_insurance
      t.string :employer_name

      #household
      t.string :section_9, :limit => 30
      t.text :special_assistance_programs
      t.string :annual_family_income
      t.integer :number_in_household


      # footer
      t.string :section_10, :limit => 30
      t.text :waiver
      t.boolean :accept_waiver
      t.text :agreements


      ##################################required fields booleans#####################

      # registrant
      t.boolean :first_name_required
      t.boolean :middle_name_required
      t.boolean :last_name_required
      t.boolean :prefix_required
      t.boolean :suffix_required
      t.boolean :date_of_birth_required
      t.boolean :mobile_phone_number_required
      t.boolean :home_phone_number_required
      t.boolean :sex_required
      t.boolean :address_required
      #ethnicity
      t.boolean :ethnicity_required
      t.boolean :lives_with_required
      t.boolean :t_shirt_size_required

      #membership
      t.boolean :membership_status_required

      #health
      t.boolean :allergies_required
      t.boolean :medical_conditions_required
      t.boolean :medications_required

      # school
      t.boolean :school_name_required
      t.boolean :school_district_required

      # guardian
      t.boolean :guardian_1_name_required
      t.boolean :guardian_1_relationship_required
      t.boolean :guardian_1_address_required
      t.boolean :guardian_1_phone_required
      t.boolean :guardian_1_email_required
      # guardian
      t.boolean :guardian_2_name_required
      t.boolean :guardian_2_relationship_required
      t.boolean :guardian_2_address_required
      t.boolean :guardian_2_phone_required
      t.boolean :guardian_2_email_required

      # emergency
      t.boolean :emergency_1_name_required
      t.boolean :emergency_1_relationship_required
      t.boolean :emergency_1_address_required
      t.boolean :emergency_1_phone_required
      t.boolean :emergency_1_email_required

      t.boolean :emergency_2_name_required
      t.boolean :emergency_2_relationship_required
      t.boolean :emergency_2_address_required
      t.boolean :emergency_2_phone_required
      t.boolean :emergency_2_email_required


      # insurance
      t.boolean :insurance_company_required
      t.boolean :insurance_policy_number_required
      t.boolean :insurance_group_number_required
      t.boolean :employer_insurance_required
      t.boolean :employer_name_required

      #household
      t.boolean :special_assistance_programs_required
      t.boolean :annual_family_income_required
      t.boolean :number_in_household_required




      # registrant
      t.boolean :first_name_display
      t.boolean :middle_name_display
      t.boolean :last_name_display
      t.boolean :prefix_display
      t.boolean :suffix_display
      t.boolean :date_of_birth_display
      t.boolean :mobile_phone_number_display
      t.boolean :home_phone_number_display
      t.boolean :sex_display
      t.boolean :address_display
      #ethnicity
      t.boolean :ethnicity_display
      t.boolean :lives_with_display
      t.boolean :t_shirt_size_display

      #membership
      t.boolean :membership_status_display

      #health
      t.boolean :allergies_display
      t.boolean :medical_conditions_display
      t.boolean :medications_display

      # school
      t.boolean :school_name_display
      t.boolean :school_district_display

      # guardian
      t.boolean :guardian_1_name_display
      t.boolean :guardian_1_relationship_display
      t.boolean :guardian_1_address_display
      t.boolean :guardian_1_phone_display
      t.boolean :guardian_1_email_display
      # guardian
      t.boolean :guardian_2_name_display
      t.boolean :guardian_2_relationship_display
      t.boolean :guardian_2_address_display
      t.boolean :guardian_2_phone_display
      t.boolean :guardian_2_email_display

      # emergency
      t.boolean :emergency_1_name_display
      t.boolean :emergency_1_relationship_display
      t.boolean :emergency_1_address_display
      t.boolean :emergency_1_phone_display
      t.boolean :emergency_1_email_display

      t.boolean :emergency_2_name_display
      t.boolean :emergency_2_relationship_display
      t.boolean :emergency_2_address_display
      t.boolean :emergency_2_phone_display
      t.boolean :emergency_2_email_display


      # insurance
      t.boolean :insurance_company_display
      t.boolean :insurance_policy_number_display
      t.boolean :insurance_group_number_display
      t.boolean :employer_insurance_display
      t.boolean :employer_name_display

      #household
      t.boolean :special_assistance_programs_display
      t.boolean :annual_family_income_display
      t.boolean :number_in_household_display
      
      t.string :stripe_customer_id
      t.string :stripe_subscription_id
      
      t.boolean :paid
      t.boolean :master

    

      t.timestamps
    end
  end
end
