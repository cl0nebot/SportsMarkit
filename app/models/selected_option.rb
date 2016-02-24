class SelectedOption < ActiveRecord::Base
  belongs_to :user
  belongs_to :form
  belongs_to :option
end
