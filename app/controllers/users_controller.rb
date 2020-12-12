class UsersController < ApplicationController
    skip_before_action :verified_user, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        if @user = User.create(user_params)
            session[:user_id] = @user.id
            redirect_to @user
        else
            redirect_to new_user_path
        end
    end

    def show
        #byebug
       if current_user.id == params[:id].to_i
        @user = User.find(params[:id])
       else
        redirect_to root_url
       end
    end

    private

    def user_params
        #byebug
        params.require(:user).permit(:name, :password, :happiness, :nausea, :height, :tickets, :admin)
    end

end