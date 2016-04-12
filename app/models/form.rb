class Form < ActiveRecord::Base
  belongs_to :formable, polymorphic: true
  belongs_to :submittable, polymorphic: true
  belongs_to :submitter, class_name: "User", foreign_key: "submitter_id"
  has_many :options
  has_one :selected_option

  enum payment_type: { online: 0, manual: 1 }

  attr_accessor :stripe_token

  def self.create_master(params={}, form_params)
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

  def get_data
    (data.try(:[], 'fields').try(:values) || {}).to_json
  end
end
