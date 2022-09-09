class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new params.require(:user).permit(
            :name,
            :email,
            :password
        )

        if @user.save
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
