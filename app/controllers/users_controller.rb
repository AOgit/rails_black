class UsersController < ApplicationController
  def index
  	if user = current_user
  	  redirect_to "/orgs/index"
  	end
  end

  def create
    user = User.create(user_params)
    if user.valid?
      last_user = User.last
      session[:user_id] = last_user.id
      redirect_to "/groups"
    else
      flash[:reg_errors] = user.errors.full_messages
      redirect_to :back
    end
  end

  def login 
    user = User.find_by(email: params[:session][:email].downcase, password: params[:session][:password])
	if user
	  session[:user_id] = user.id
	  redirect_to "/groups"
	else
	  flash[:login_error] = "Invalid Login Credentials"
	  redirect_to :back
	end
  end

  def logout
    session.delete(:user_id)
  	redirect_to "/"
  end

  def show
  	@user = User.find(current_user.id)
  	@orgs = Org.all
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end	

end
