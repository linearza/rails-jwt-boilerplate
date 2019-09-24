class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login create]
  attr_reader :current_user

  # POST /create
  def create
    @user = User.create(user_params)
    if @user.save
      response = { message: 'User created successfully'}
      render json: response, status: :created
    else
      render json: @user.errors.full_messages, status: :bad
    end
  end

  # POST /login
  def login
    authenticate params[:email], params[:password]
  end

  # GET /users/me
  def me
    hash = UserSerializer.new(current_user).serializable_hash
    render json: hash
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
    hash = UserSerializer.new(@user).serializable_hash
    render json: hash

    # if current_user and current_user.admin?
    #   @user = User.find(params[:id])
    # else
    #   redirect_to root_path
    # end
  end

  private

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      render json: {
        access_token: command.result,
        message: 'Login Successful'
      }
    else
      render json: { error: command.errors.full_messages }, status: :unauthorized
    end
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
