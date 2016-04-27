class FormBuilder::Radio < FormBuilder::Base
  def field_tag
    field_options.each_with_index.map do |radio, index|
      tag = radio_button_tag field_name, radio["label"], radio["checked"] == "checked", base_options(index: index)
      label = label_tag "#{field_name}_#{index}", radio["label"], class: "text-black"
      content_tag :div, (tag + label).html_safe, class: "radioer col-md-4"
    end.join
  end

  def base_options(opt={})
    options = super
    options.merge!({ id: "#{field_name}_#{opt[:index]}" })
  end

  def wrap_input(input)
    input = content_tag(:div, input.html_safe, class: "form-group clearfix")
  end
end
