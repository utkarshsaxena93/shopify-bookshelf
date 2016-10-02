class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id).paginate(:page => params[:page], per_page: 50).order('id DESC')
  end

  def show
    @user = User.find(params[:id])
  end

  def dashboard
    @user = current_user
    @books = @user.books
    @userRecommendations = Recommendation.where("user_id": current_user.id)
  end

  def destroy
    @user = current_user

    respond_to do |format|
      if @user.destroy()
        format.html { redirect_to root_path, alert: 'Your account has been deleted!' }
        format.json { head :no_content }
      else
        format.html { redirect_to root_path, alert: 'Failed to delete account. Please try again.' }
      end
    end
  end

  def create_invitation
    userEmail = params[:email]
    userExists = User.where(email: userEmail)
    InviteUser.send_invite_email(userEmail, current_user)

    # if userExists.empty?
    #   if userEmail.include? "@shopify.com"
    #     InviteUser.send_invite_email(userEmail, current_user)
    #     redirect_to :back, notice: "Invitation successfully sent."
    #   else
    #     redirect_to :back, alert: "Invalid email. You can only invite users with @shopify email account.."
    #   end
    # elsif !userExists.empty?
    #   byebug
    #   InviteUser.send_invite_email(userEmail, current_user)
    #   redirect_to :back, alert: "User already exists. No invitation sent."
    # end
  end
end
