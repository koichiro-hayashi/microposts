class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  before_action :set_user, only: [:edit, :update]

  def edit # ユーザー情報の編集
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: '編集内容を保存しました!'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "新規登録が完了しました!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :area,
                                 :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end