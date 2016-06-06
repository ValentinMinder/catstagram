class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :ban, :ban_update, :edit_roles, :save_roles]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @title = "Photos uploaded by " + @user.username
    @item = @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # GET /users/1/ban
  # Automatically renders ban.html.erb
  def ban
  end

  # PATCH/PUT /users/1/ban
  # PATCH/PUT /users/1.json/ban
  # Allows the update of banned_until field 
  def ban_update
    respond_to do |format|
      if @user.update(ban_params)
        format.json { render :ban, status: :ok, location: @user }
        if @user.is_banned
          format.html { redirect_to @user, notice: 'User was successfully banned.' }
        else 
          format.html { redirect_to @user, notice: 'User was successfully unbanned.' }
        end
      else
        format.html { render :ban }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_roles

  end

  def save_roles
    @user.roles.each do |role|
      @user.roles.delete(role)
    end

    if params[:user]
      for id_role in params[:user][:role_ids]
        role = Role.find(id_role)
        @user.roles << role
      end
    end

    redirect_to users_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Ban may only edit banned_until param
    def ban_params
      params.require(:user).permit(:banned_until)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # Does not allow :banned_until parameter
    def user_params
      params.require(:user).permit(:username, :avatar_url, :biography)
    end
end
