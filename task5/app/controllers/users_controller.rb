class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books.preload(:favorites)
    @book = Book.new
  end

  def index
    @users = User.all.preload(:followees, :followers)
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    return redirect_to user_path(current_user.id) if @user.id != current_user.id
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      @books = Book.where(user_id: params[:id])
      render "edit"
    end
  end

  def followers
    @relationships = Relationship.where(follower_id: params[:user_id])
  end

  def followees
    @relationships = Relationship.where(followee_id: params[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end