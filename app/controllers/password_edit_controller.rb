class PasswordEditController < ApplicationController
    before_action :find_user, only: [:edit, :update]
    
    def edit
    end

    def update
        if @user && @user.authenticate(params[:current_password])
            puts "Password updated successfully"
            flash[:notice] = 'Password changed successfully'
            redirect_to root_path
        else
            puts "Password not updated"
            flash[:error] = 'Password not changed'
            redirect_to edit_user_password_edit_path
        end
    end

    private

    def find_user
        @user = User.find(params[:user_id])
    end
end
