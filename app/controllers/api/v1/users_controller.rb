class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, only: %i[show destroy update]

  def index
    @users = User.all
    render json: @users, except: [:password_digest], status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, except: [:password_digest], status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    return if @user.update(user_params)

    render json: { errors: @user.errors.full_messages },
           status: :unprocessable_entity
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.permit(:username, :name, :email, :password)
    # params.permit(:username, :name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
