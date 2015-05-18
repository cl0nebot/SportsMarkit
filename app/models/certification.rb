class Certification < ActiveRecord::Base
  has_many :certification_badges #TODO dependent destroy?
  accepts_nested_attributes_for :certification_badges, :reject_if => :all_blank, :allow_destroy => true

  def index_position
    array = []
    certifications = Certification.all
    certifications.each do |c|
      array << c.id
    end
    array.uniq.find_index(id) + 1
  end
end
