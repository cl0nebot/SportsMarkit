class FormBuilder::Checkboxes < FormBuilder::Base
  def field_tag
    rand = SecureRandom.hex
    tags = field_options.each_with_index.map do |checkbox, index|
      tag = check_box_tag(field_name, checkbox["label"], checkbox["checked"] == "checked", base_options(index: index, rand: rand))
      tag + label_tag("#{field_name}_#{index}_#{rand}", "#{checkbox['label']}")
    end.join
    if @data['field_options']['include_other_option']
      tags << text_field_tag("user_data[field_#{rand}][#{field_name}][]", nil, placeholder: 'Other')
    end
    tags
  end

  def base_options(opt)
    options = {
      class: "#{field_name} #{ 'required' if required?}",
      id: "#{field_name}_#{opt[:index]}_#{opt[:rand]}",
      name: "user_data[field_#{opt[:rand]}][#{field_name}][]"
    }
    options.merge!({ "data-required-any" => ".#{field_name}" }) if required?
    options
  end

  def wrap_input(input)
    content_tag(:div, input.html_safe, class: "checkboxer form-group")
  end
end
