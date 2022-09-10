class PasswordEditController < ApplicationController
    def edit
        @user = User.find(params[:user_id])

    end

    def update
        if user && user.authenticate(params[:password])
            flash[:notice] = 'Password changed successfully'
            redirect_to root_path
        else
            flash[:error] = 'Password not changed'
            redirect_to edit_user_password_edit_path
        end
    end
end
