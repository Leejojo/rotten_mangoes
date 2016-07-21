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
        redirect_to admin_user_path(@user), notice: "Welcome aboard, #{@user.firstname}"
      else
        render :new
      end
    end

    def index
      @users = User.all.page(params[:page]).per(5)
    end

    def edit
      @user = User.find(params[:id])
      render :edit
    end

    def show
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])

      if @user.update_attributes(user_params)
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    protected

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
    end

  end
end