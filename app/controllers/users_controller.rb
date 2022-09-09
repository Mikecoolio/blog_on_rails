class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation
        )

        if @user.save
            flash.notice = 'User has been successfully created'
            redirect_to root_path
        else
            render :new, status: 303
        end
    end

    def index

    end

    def show

    end
end
