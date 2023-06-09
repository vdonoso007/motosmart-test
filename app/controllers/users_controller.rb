class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def login
    user = User.where("mail = ? AND password = ?", params[:mail], params[:password]).first
    
    if user.present?
      user.token = user.create_token(user.name, params[:mail], user.uuid)
      user.save
      render json: { access_token: user.token}
    else
      render json: "Credenciales invalidas", status: 401
    end

  end

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.uuid = @user.get_uuid
    @user.token = @user.create_token(@user.name, @user.mail, @user.uuid)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :mail, :password)
    end
end
