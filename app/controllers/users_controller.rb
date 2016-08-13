class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def dashboard
    @user = current_user
    @books = @user.books
  end

  def create_invitation
    userExists = User.where(email: params[:email])
    invitationAccepted = user.pluck(:invitation_accepted_at)
    
    if userExists.empty?
      User.invite!({:email => params[:email]}, current_user)
      redirect_to user_dashboard_path, notice: "Invitation successfully sent."
    elsif !userExists.empty? and ! invitationAccepted.any?
      User.invite!({:email => params[:email]}, current_user)
      redirect_to user_dashboard_path, alert: "User has already been invited. Seding a fresh invite."
    else
      redirect_to user_dashboard_path, alert: "User already exists. No invitation sent."
    end
  end

end
