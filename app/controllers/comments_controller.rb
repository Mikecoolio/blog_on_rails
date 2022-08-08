class CommentsController < ApplicationController
    #before_action :find_post

    def create
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
        p @comment
        p params, "IN DESTROY"
        @comment = Comment.find params[:id] 
        # @comment.destroy
		#@post = Post.find(params[:id])
        if @comment.present?
            @comment.destroy
            # redirect_to root_path
            #redirect_to post_path(@comment.post), notice: 'Comment was successfully destroyed.'
            redirect_to post_path(@comment.post_id), notice: 'Comment was successfully destroyed.'
        else
            redirect_to root_path, status: 303
        end
    end

    private

    def find_post
        @post = Post.find(params[:id])
    end
end
    