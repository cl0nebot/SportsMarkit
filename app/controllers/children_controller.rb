class ChildrenController < ApplicationController
  before_action :find_user
  before_action :find_child, only: [:show, :edit, :update, :destroy]

  def index
    @children = @user.children
  end

  def new
    @child = @user.children.build
  end

  def create
    @child = @user.children.create child_params
    if @child.save
      @child.create_profile
      respond_to do |f|
        f.html { redirect_to :back }
        f.json
      end
    else
      respond_to do |f|
        f.html { render :new }
        f.json { render json: { errors: @child.errors_full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @child.update child_params
      redirect_to action: :index
    else
      render :new
    end
  end

  def destroy
    @child.destroy
    redirect_to :back
  end

  private

  def child_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def find_child
    @child = @user.children.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end