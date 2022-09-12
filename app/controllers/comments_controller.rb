class CommentsController < ApplicationController
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
    