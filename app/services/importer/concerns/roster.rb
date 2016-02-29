module Importer::Concerns::Roster
  def create_roster(attributes, team_id)
    attributes = ActiveSupport::HashWithIndifferentAccess.new(attributes)
    if attributes['mobile_phone_number'].present?
      password = User.generate_temporary_password(attributes['first_name'])
      user_params = attributes.slice('first_name', 'last_name', 'mobile_phone_number').merge(password: password)
      user = User.where(mobile_phone_number: attributes['mobile_phone_number']).first_or_initialize
      if user.update_attributes(user_params)
        user.create_profile unless user.profile.present?
        unless role_exists?(user, team_id, attributes)
          role = Role.create_new_role(user.id, "Athlete", attributes)
          yield role unless role.persisted?
        end
      else
        yield user
      end
    else
      role = UserlessRole.create_new_role("Athlete", attributes)
      yield role unless role.persisted?
    end
  end

  def role_exists?(user, team_id, atts)
    Role.where(mobile_phone_number:  atts['mobile_phone_number'], user_id: user.id, role: "Athlete", status: "Active", roleable_type: "Team", roleable_id: team_id).present?
  end
end