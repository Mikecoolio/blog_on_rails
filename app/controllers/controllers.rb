# application_controller.rb
class ApplicationController < ActionController::Base
    require "cancan" 
    def current_user
        @current_user ||= User.find_by_id session[:user_id]
    end
    helper_method :current_user

    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?

    def authenticate_user!
        redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
    end

    def authenticated_user!
        redirect_to root_path, flash[:alert]="Please sign in" unless user_signed_in?
    end
end

# comments_controller.rb
class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticated_user!
    
    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.new(params.require(:comment).permit(:body))
        @comment.post = @post
        @comment.user = current_user

 
        if @comment.save
            puts "succesffully created comment"
            redirect_to post_path(@comment.post), notice: 'Comment was successfully created.'
        else
            puts "not succesffully created comment"
            render 'posts/show'
        end
    end

    def destroy
        @comment = Comment.find params[:id] 

        if can?(:crud, @comment)
            @comment.destroy
            redirect_to post_path(@comment.post_id), notice: 'Comment was successfully destroyed.'        
        else
            redirect_to root_path
        end
    
    end
end

# posts_controller.rb
class PostsController < ApplicationController
    before_action :find_post_id, only: [:edit, :update, :destroy, :show]
    before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]
    before_action :authorize_user!, only:[:edit, :update, :destroy]
    before_action :authenticated_user!, only: [:edit, :update, :create, :destroy]
    # skip_before_action :verify_authenticity_token

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user

        if @post.save!
            redirect_to post_path(@post), method: :post, notice: 'Post was successfully created.'
        else
            flash[:error] = "Invalid post"
            render :new
        end
    end

    def show
        @comment = Comment.new
        @comments = @post.comments.order(created_at: :desc)
    end

    def index
        @posts = Post.order(id: :desc)
    end

    def update
        if @post.update(post_params)
            redirect_to post_path(@post)
        else
            flash[:error] = "Error! Post was not updated"
            render :edit  
        end
    end

    def destroy
        if @post.present?
            @post.destroy
        end
        redirect_to posts_path
    end

    def edit
    end

    private

    def authorize_user!
        redirect_to root_path, alert: "Not authorized" unless can?(:crud, @post)
    end

    def find_post_id
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end
end

# sessions_controller.rb
class SessionsController < ApplicationController
    def new
    end
    
    def create
        @user = User.find_by_email params[:email]

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
        
# users_controlller.rb
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

    def password_edit
    end

    def password_update
        if @user && @user.authenticate(params[:current_password])
            if @user.update(params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation))
                puts "Password updated successfully"
                flash[:notice] = 'Password changed successfully'
                redirect_to root_path
            else
                puts "Password not updated"
                flash[:error] = 'Password not changed'
                redirect_to edit_password_path
            end
        end
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
