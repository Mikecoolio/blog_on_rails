class PostsController < ApplicationController
    before_action :find_post_id, only: [:edit, :update, :destroy, :show]
    before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]
    before_action :authorize_user!, only:[:edit, :update, :destroy]
    # before_action :authenticated_user!, only: [:edit, :update, :create, :destroy]

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