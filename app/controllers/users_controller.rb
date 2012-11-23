class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :show, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  
  def following
  
  @user = User.find(params[:id])
  @username = User.find(params[:id]).name  
  @title = "#{@username} is Following these people..."
  @users = @user.followed_users
  render 'show_follow'
  end

  def followers
  
  @user = User.find(params[:id])
  @username = User.find(params[:id]).name
  @title = "Following #{@username} are these people..."
  @users = @user.followers
  render 'show_follow'
  end






  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def destroy
  @user = User.find(params[:id]).destroy
  flash[:success] = "User has been deleted!"
  redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])


    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      #good!
      sign_in @user
      flash[:success] = "Profile"
      redirect_to user_path(@user)
    else
      render 'edit'
    end

  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to the Ruby app!"
  		redirect_to user_path(@user)
  	else
  		render 'new'
  	end
  end

  private

 

  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user)
      redirect_to '/'
    end
  end

   def admin_user
     if current_user.admin = true
       #nothing
     else
       redirect_to '/'
   end
 end





end
