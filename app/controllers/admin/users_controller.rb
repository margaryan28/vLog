class Admin::UsersController < Admin::ApplicationController
  
  before_filter :verify_logged_in


  def new
    @page_title = 'Vlog | Add Category'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User created successfully'
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'User updated successfully'
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'User removed successfully'
      redirect_to admin_users_path
    else
      render 'index'
    end
  end

  def index
    if params[:search]
        @users = User.search(params[:search]).all.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    else
        @users = User.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    end
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password)      
    end
end
