class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: :destroy

def index
  @users = User.paginate(page: params[:page])
end

  # GET app/views/users/show.html.erb
  def show
    # @user = User.first
    @user = User.find(params[:id])
  end

  # GET app/views/users/new.html.erb
  def new
    @user = User.new
  end

  # POST /users
  def create
    # params => user => user.save => if ... else ... end
    @user = User.new(user_params)
    if @user.save
      # => Success
      reset_session
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to user_url(@user)
    else
      # => Failure
      render 'new', status: :unprocessable_entity
    end
  end


  def edit
    @user = User.find(params[:id])
    # => app/views/users/edit.html.erb
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end

  private

  # Strong Parameters
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

    # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end

    # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless @user == current_user
  end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
