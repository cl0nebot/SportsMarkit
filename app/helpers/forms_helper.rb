module FormsHelper
  
  
  
  def button_styling(owner, owner_id, object, field_name)
    field = field_name
    display_field = "#{field_name}_display"
    required_field = "#{field_name}_required"
    if (owner.constantize.find(owner_id).forms.where(object: object).last.try(required_field.to_sym).try(:present?) == true)
      button_style = "btn btn-danger"
    elsif (owner.constantize.find(owner_id).forms.where(object: "Registration").last.try(display_field.to_sym).try(:present?) == true)
      button_style = "btn btn-success"
    else
      button_style = "btn btn"
    end
  end
  
end
