class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

  def create
    # render plain: params[:post].inspect
    @user = User.new(user_params)

    if (@user.save)
      redirect_to @user
    else
      render 'new'
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to @user
      else
        render 'users/edit'
      end
    end

    private def user_params
      params.require(:library).permit(:username, :date_of_birth, :email, :image)
    end

  end
end
