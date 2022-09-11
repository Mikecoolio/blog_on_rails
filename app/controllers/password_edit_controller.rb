class PasswordEditController < ApplicationController
    before_action :find_user, only: [:edit, :update]
    


    private

    def find_user
        @user = User.find(params[:user_id])
    end
end
