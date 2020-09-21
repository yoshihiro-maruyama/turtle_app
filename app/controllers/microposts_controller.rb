class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def index
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments
    @comment = current_user.comments.new
  end

  def new
    @micropost = current_user.microposts.build if logged_in?
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to micropost_path(@micropost)
    else
      render new_micropost_path
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to user_path(current_user)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

end
