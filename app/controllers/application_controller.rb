class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_search


  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

 
  def set_search
    #@search = Article.search(params[:q])
    @search = Micropost.ransack(params[:q]) #ransackメソッド推奨
    @microposts = @search.result
  end
end
