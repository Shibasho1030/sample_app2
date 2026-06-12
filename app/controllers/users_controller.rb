class UsersController < ApplicationController
  def index; end

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
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to user_url(@user)
    else
      # => Failure
      render 'new', status: :unprocessable_entity
    end
  end

  private

  # Strong Parameters
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
