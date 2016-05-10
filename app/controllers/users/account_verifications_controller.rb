class Users::AccountVerificationsController < ApplicationController
    def new
        @user = current_user
    end

    def create
      user = User.find_by_email params[:user][:email]

      if user
        user.generate_account_verification_data
        AccountVerificationsMailer.send_verification_instructions(user).deliver_later
      end
    end

    def edit
      @user = User.find_by_account_verification_token params[:id]
        if @user.update(activated: true)
        sign_in(@user)
        redirect_to root_path, notice: "Account was activated successfully"
      else
        flash[:notice] = "Account activation failed, please try again or contact support"
        render :edit
      end

    end

  end
