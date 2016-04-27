class FormBuilder::Base
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper

  def initialize(data, object)
    @data = data
    @object = object
  end

  def self.init(column, object)
    ("FormBuilder::" + column["field_type"].camelize).constantize.new(column, object)
  end

  def render
    label + wrap_input(field_tag + required_container)
  end

  def required_container
    content_tag :div, nil, class: "help-block with-errors"
  end

  def base_options(options={})
    { class: "form-control #{ 'required' if required?}", required: required?, name: "user_data[#{field_name}]" }
  end

  def value
    @object.try(field_name)
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