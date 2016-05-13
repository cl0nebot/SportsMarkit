class FormBuilder::Radio < FormBuilder::Base
  def field_tag
    rand = SecureRandom.hex
    tags = field_options.each_with_index.map do |radio, index|
      rand_index = "#{index}_#{rand}"
      tag = radio_button_tag field_name, radio["label"], radio["checked"] == "checked", base_options(index: rand_index)
      label = label_tag "#{field_name}_#{rand_index}", radio["label"], class: "text-black"
      content_tag :div, (tag + label).html_safe, class: "radioer col-md-4"
    end.join
    if @data['field_options']['include_other_option']
      tag = radio_button_tag field_name, "Other", false, base_options.merge('data-other-radio' => true)
      label = label_tag "#{field_name}_", "Other", class: "text-black"
      tags << content_tag(:div, (tag + label).html_safe, class: "radioer col-md-4")
      tags << text_field_tag(field_name, nil, base_options.merge(placeholder: 'Other', class: '', required: false, 'data-other' => true))
    end
    tags
  end

  def base_options(opt={})
    options = super
    options.merge!({ id: "#{field_name}_#{opt[:index]}" })
  end

  def wrap_input(input)
    content_tag(:div, input.html_safe, class: "form-group clearfix")
  end
end
