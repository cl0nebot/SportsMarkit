class Address < ActiveRecord::Base
  include Location
  belongs_to :addressable, :polymorphic => true
  
  def city_and_state
    "#{city}-#{state}"
  end
 #
 #  def city_state # schools
 #    if school_id.present?
 #      comma = (school.city.present? && school.state.present?) ? "," : ""
 #      "#{school.city}#{comma} #{school.state}"
 #    else
 #      comma = (city.present? && state.present?) ? "," : ""
 #      "#{city}#{comma} #{state}"
 #    end
 #  end
 #
 #  def full_address
 #
 #  end
 #
 #  def city_and_state
 #    if city.present? && state.present?
 #      "#{city}, #{state}"
 #    elsif state.present? && !city.present?
 #      "#{state}"
 #    else
 #      ""
 #    end
 #  end
 #
 #  def zip_and_ext
 #    if !zip.present?
 #      ""
 #    elsif zip.present? && zip_ext.present?
 #      "#{zip}-#{zip_ext}"
 #    elsif !zip_ext.present?
 #      "#{zip}"
 #    end
 #  end
 #
 #  def address
 #   address = "#{address_1}#{", " if address_2.present? }#{address_2 if address_2.present?}#{"," if (city_and_state.present? && address_1.present?) } #{city_and_state if city_and_state.present?} #{zip_and_ext}"
 #   address.strip
 #  end
  
  
  
end
