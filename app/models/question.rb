class Question < ActiveRecord::Base
  enum field_type: [:text_field, :select, :text_area, :checkbox, :radio_button]

  vaildates :title, :field_type, :position
end