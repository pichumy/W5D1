class UsersController < ApplicationController
  def new
     @user = User.new
     render :new
  end

  def edit
    @user = User.find(params[:id])
    render :new
  end

  def create
    @user = User.new(user_params)
    p "==================="
    p params
    p '==================='
    if @user.save
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
