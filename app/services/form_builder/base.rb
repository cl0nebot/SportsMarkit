class FormBuilder::Base
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper

  def initialize(data, object, user)
    @data = data
    @object = object
    @user = user
  end

  def self.init(column, object, user)
    ("FormBuilder::" + column["field_type"].camelize).constantize.new(column, object, user)
  end

  def render
    label + wrap_input(field_tag + required_container)
  end

  def required_container
    content_tag :div, nil, class: "help-block with-errors"
  end

  def base_options(options={})
    @base_options ||= { class: "form-control #{ 'required' if required?}", required: required?, name: "user_data[field_#{SecureRandom.hex}][#{field_name}]" }
  end

  def value
    prefill = @data.fetch("field_options",{})['prefill_with']
    @user.send(prefill) if prefill.present? && @user
  end

  def required?
    @data["required"] == "true"
  end

  def field_name
    @data["label"].parameterize('_')
  end

  def wrap_input(input)
    input = content_tag(:div, input.html_safe, class: "input-wrapper form-group")
    input = content_tag(:div, input.html_safe, class: "inputer")
  end

  def label
    label_tag @data["label"].parameterize('_'), @data["label"]
  end

  def field_options
    @data["field_options"]["options"].values
  end
end