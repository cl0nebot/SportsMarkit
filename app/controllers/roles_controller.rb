class RolesController < ApplicationController


  def create
    user_id = params[:role][:user_id]
    roleable_id = params[:role][:roleable_id]
    roleable_type = params[:role][:roleable_type]
    @join = params[:join]
    Role.create(user_id: user_id, roleable_id: roleable_id, roleable_type: roleable_type, status: "Pending")
    respond_to do |format|
      format.js
      format.html {redirect_to :back}
    end
  end

  def assign
    @users = User.all
  end

  def admin_assign_role
    user_id = params[:role][:user_id]
    role_name = params[:role_name]
    roleable_id = params[:roleable_id]
    roleable_type = params[:roleable_type]

    @role = Role.create(user_id: user_id, roleable_id: roleable_id, roleable_type: roleable_type, role: role_name, status: "Active", date_added: Date.today, accepting_user_id: current_user )
    user = User.find(@role.user_id)
    SendEmail.notify_user_of_admin_role(user, @role.role, @role.roleable_type.constantize.find(@role.roleable_id))
    redirect_to :back
  end

  def roleable

  end

  def manage
    unless params[:child]
      @object = params[:object_type].constantize.find(params[:object_id])
    else
      @object = params[:roleable_type].constantize.find(params[:roleable_id])
    end
    @role = Role.find(params[:role_id])
    if params[:command] == "remove"
      @role.destroy
    else
      @role.update_attributes(status: "Active")
    end
  end

end
