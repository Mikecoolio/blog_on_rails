class SessionsController < ApplicationController
    def new
    end
    
    def create
        @user = User.find_by(email: params[:email])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to root_path, {notice: "Logged In"}
        else
            render :new, {alert: "Wrong email or password", status: 303}
        end
    end

    def destroy
        session[:user_id] = nil
        flash.notice = "Logged Out"
        redirect_to root_path
    end
end
