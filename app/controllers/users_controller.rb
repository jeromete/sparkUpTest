class UsersController < ApplicationController
  def index
    @good_users = User.where(error_message: '').order(:created_at)
    @bad_users = User.where.not(error_message: '').order(:created_at)
  end
end
