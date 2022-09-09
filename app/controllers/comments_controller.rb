class CommentsController < ApplicationController
    before_action :authenticate_user!
            
    def create
        @comment = Comment.new(params.require(:comment).permit(:body))
        @comment.post = Post.find(params[:post_id])

        if @comment.save
            redirect_to post_path(@comment.post), notice: 'Comment was successfully created.'
        else
            render 'posts/show', status: 303
        end
    end

    def destroy
        p @comment
        p params, "IN DESTROY"
        @comment = Comment.find params[:id] 

        if @comment.present?
            @comment.destroy
            redirect_to post_path(@comment.post_id), notice: 'Comment was successfully destroyed.'
        else
            redirect_to root_path, status: 303
        end
    end
end
    