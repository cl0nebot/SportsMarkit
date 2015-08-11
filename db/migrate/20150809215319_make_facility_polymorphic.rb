class MakeFacilityPolymorphic < ActiveRecord::Migration
  def change
    add_column :facilities, :facilitatable_type, :string
    add_column :facilities, :facilitatable_id, :integer
    
    Facility.all.each do |facility|
      if facility.school_id.present?
        facility.update_attributes(facilitatable_type: "School", facilitatable_id: facility.school_id)
      end
    end
  
  end
end
