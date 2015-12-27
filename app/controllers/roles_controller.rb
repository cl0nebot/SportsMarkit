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
   SendEmail.notify_user_of_admin_role(User.find(@role.user_id), @role.role, @role.roleable_type.constantize.find(@role.roleable_id)
   # respond_to do |format|
   #   format.js
   #   format.html {redirect_to :back}
   # end
   redirect_to :back
  end
  
  def roleable

  end
end
