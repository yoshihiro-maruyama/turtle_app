class LikesController < ApplicationController

  before_action :set_like

  def create
      user = current_user
      @micropost = Micropost.find(params[:micropost_id])
      like = Like.create(user_id: user.id, micropost_id: @micropost.id)
  end
  def destroy
      user = current_user
      @micropost = Micropost.find(params[:micropost_id])
      like = Like.find_by(user_id: user.id, micropost_id: @micropost.id)
      like.delete
  end

  private
  def set_like
      @micropost = Micropost.find(params[:micropost_id])
  end
end
