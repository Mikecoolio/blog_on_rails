class CommentsController < ApplicationController

    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.new(params.require(:comment).permit(:body, :post_id))
        @comment.post = @post

        # if @post.comments.create(params[:comment].permit(:body))
        if @comment.save
            # redirect_to @comment.post
            redirect_to post_path(@post), notice: 'Comment was successfully created.'
        else
            @comments = @post.comments.order(created_at: :desc)
            render 'posts/show', status: 303
        end
    end

    def destroy
    end

end
    