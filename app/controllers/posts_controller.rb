class PostsController < ApplicationController
    def new
        @post = Post.new
    end

    def create
        @post = Post.new(params.require(:post).permit(:title, :body))

        if @post.save
            redirect_to post_path(@post), method: :post, notice: 'Post was successfully created.'
        else
            render :new
        end
    end

    def show
        @post = find_post_id

        if @post.present? 
            redirect_to(posts_path, :notice =>  'Post was successfully created.')
        end
    end

    def index
        @posts = Post.order(id: :desc)
    end

    def update
        @post = find_post_id
    end

    def destroy
        
    end

    def edit
        @post = find_post_id
    end

    private

    def find_post_id
        Post.find(params[:id])
    end
end
