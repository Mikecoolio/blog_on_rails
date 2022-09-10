class UsersController < ApplicationController   
    before_action :find_user

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            session[:user_id] = @user.id
            flash[:alert] = 'User has been successfully created'
            redirect_to root_path
        else
            render :new, status: 303
        end
    end

    def index   
    end

    def show
    end

    def edit
    end

    def update
        if @user.update(user_params)
            redirect_to root_path, notice: 'User has been successfully updated.'
        end
    end

    def edit_password
        
    end

    private

    def find_user
        @user = User.find_by_id(params[:id])
    end

    def user_params
        params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation
        )
    end
end
