class FormBuilder::Radio < FormBuilder::Base
  def field_tag
    @data["field_options"]["options"].values.map do |radio|
      radio_button_tag field_name, 'yes', radio["checked"] == "checked", base_options
    end.join
  end
end