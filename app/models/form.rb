class Form < ActiveRecord::Base
  belongs_to :formable, polymorphic: true
  belongs_to :submittable, polymorphic: true
  belongs_to :submitter, class_name: "User", foreign_key: "submitter_id"
  has_many :options
  has_one :selected_option
  has_one :payment

  enum payment_type: { online: 0, manual: 1 }

  attr_accessor :stripe_token

  def self.master
    where(master: true).first
  end

  def registrant
    submittable
  end

  def pay!(payment_type = 'online')
    update(paid: true, payment_type: payment_type)
    track_payment
    send_registration_emails
    submittable.attend_event!(formable) if formable_type == "Event"
  end

  def track_payment
    if manual?
      create_payment(price: price_option.price)
    else
      create_payment(price: price_option.price, sm_fee: price_option.sm_fee, stripe_fee: price_option.stripe_fee)
    end
  end

  def price_option
    selected_option.option
  end

  def send_registration_emails
    master_form = Form.where(formable_type: formable_type, formable_id: formable_id, master: true).first_or_create
    SendEmail.new_registration(master_form.submitter, self).deliver if master_form.notify_creator
    if master_form.formable.teamable_type == "Club"
      master_form.formable.teamable.directors.each do |director|
        SendEmail.new_registration(director, self).deliver
      end
    end
    SendEmail.new_registration(submittable, self).deliver if submittable.email.present?
  end

  def select_pricing_option(id, params={})
    selected_option = SelectedOption.find_or_create_by(user_id:  params[:form][:submittable_id], form_id: id)
    selected_option.update_attributes(option_id: params[:registration_options])
  end

  def get_data
    form_data = (data.try(:[], 'fields').try(:values) || [])
    form_data.each do |field|
      field.delete('required') if field['required'] == 'false'
      if field['field_options']
        %w(include_other_option include_blank_option).each do |field_option_to_clear|
          field['field_options'].delete(field_option_to_clear) if field['field_options'][field_option_to_clear] == 'false'
        end
        if field['field_options']['options']
          field['field_options']['options'].each do |key, field_option|
            field_option.delete('checked') if field_option['checked'] == 'false'
          end
        end
      end
      if %w(checkboxes dropdown radio).include? field['field_type']
        if field['field_options'].try(:[], 'options')
          field['field_options']['options'] = field['field_options']['options'].values
        end
      end
    end
    form_data.to_json
  end
  
  def confirmation
    if paid?
      "#{formable_id}-#{id}-#{created_at.to_i}"
    else
      "N/A"
    end
  end
end
