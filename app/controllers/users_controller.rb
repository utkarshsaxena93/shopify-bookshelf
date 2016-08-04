class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:all]

  def all
    @users = User.all
  end

end
