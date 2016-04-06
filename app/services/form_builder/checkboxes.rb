class FormBuilder::Checkboxes < FormBuilder::Base
  def field_tag
    @data["field_options"]["options"].values.map do |checkbox|
      options = { class: "form-control #{field_name} #{ 'required' if required?}" }
      options.merge!({ "data-required-any" => ".#{field_name}" }) if required?
      check_box_tag(field_name, 'yes', checkbox["checked"] == "checked", options)
    end.join
  end
end