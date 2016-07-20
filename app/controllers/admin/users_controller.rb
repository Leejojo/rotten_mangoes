 module Admin
  class UsersController < ApplicationController
    
    before_action :check_if_user_is_admin

    def check_if_user_is_admin
      unless current_user && current_user.admin
        flash[:notice] = "Nice Try!"
        redirect_to root_path
      end
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        session[:user_id] = @user.id
        redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}"
      else
        render :new
      end
    end

    def index
      @users = User.all.page(params[:user]).per(10)
    end

    def show
      @user = User.find(params[:id])
    end

    protected

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
    end

  end
end