class PostsController < ApplicationController
    before_action :find_post_id, only: [:show, :update, :edit]

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)

        if @post.save
            redirect_to post_path(@post), method: :post, notice: 'Post was successfully created.'
        else
            flash[:error] = "Invalid post"
            render :new
        end
    end

    def show
        # if @post.present? 
        #     redirect_to(posts_path, :notice =>  'Post was successfully created.')
        # else
        #     render :show
        # end
        @post = Post.find(params.require(:id))
    end

    def index
        @posts = Post.order(id: :desc)
    end

    def update
        if @post.update(post_params)
            redirect_to posts_path, :notice => 'Post was successfully updated.'
        end
    end

    def destroy
        
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