class PostsController < ApplicationController
    before_action :find_post_id, only: [:edit, :update, :show, :destroy]
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
        @post = Post.find(params[:id])
        @comment = Comment.new
        @comments = @post.comments.order(created_at: :desc)
    end

    def index
        @posts = Post.order(id: :desc)
        @users = User.order(id: :desc)

        puts current_user
        puts params
    end

    def update
        if @post.update(post_params)
            redirect_to post_path(@post)
        else
            flash[:error] = "Error! Post was not updated"
            render :update  
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

    def find_post_id
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end
end