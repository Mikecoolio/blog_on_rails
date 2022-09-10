class CommentsController < ApplicationController
    before_action :authenticate_user!
    # before_action :find_post
            
    def create
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

        if @comment.present?
            @comment.destroy
            redirect_to post_path(@comment.post_id), notice: 'Comment was successfully destroyed.'
        else
            redirect_to root_path, status: 303
        end
    end

    private

    def find_post
        @post = Post.find(params[:post_id])
    end
end
    