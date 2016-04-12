class FormBuilder::Checkboxes < FormBuilder::Base
  def field_tag
    field_options.each_with_index.map do |checkbox, index|
      tag = check_box_tag(field_name, checkbox["label"], checkbox["checked"] == "checked", base_options(index: index))
      tag + label_tag("#{field_name}_#{index}", "#{checkbox['label']}")
    end.join
  end

  def base_options(opt)
    options = {
      class: "#{field_name} #{ 'required' if required?}",
      id: "#{field_name}_#{opt[:index]}",
      name: "user_data[#{field_name}][]"
    }
    options.merge!({ "data-required-any" => ".#{field_name}" }) if required?
    options
  end

  def wrap_input(input)
    input = content_tag(:div, input.html_safe, class: "checkboxer form-group")
  end
end
