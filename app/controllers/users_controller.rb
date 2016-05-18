class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      session[:user_id] = @user.id
      # redirect_to home_path, notice: "Account created!"

      @user.generate_account_verification_data
      AccountVerificationsMailer.send_verification_instructions(@user).deliver_later
      render "users/account_verifications/create"
    else
      render :new
    end
  end

  def edit

    @user = User.find(params[:id])

  end


  def update
    user_params = params.require(:user).permit(:first_name, :last_name, :email,
                                               :password, :password_confirmation)
     @user = User.find(params[:id])
     if @user.update_attributes(user_params)
       redirect_to home_path, notice: "Profile updated!"
     else
       render 'update'
     end
   end

end
