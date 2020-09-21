class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.micropost_id = params[:micropost_id]
    @micropost = @comment.micropost
    @micropost.create_notification_comment!(current_user, @comment.id)
    
    @comment.save
    
    redirect_back(fallback_location: root_path)
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :micropost_id)
    end
end
