class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :ban, :ban_update, :edit_roles, :save_roles]

  #before_filter :authenticate_user!, only: [:edit, :update, :destroy, :ban, :ban_update, :edit_roles, :save_roles]
  load_and_authorize_resource :except => [:index]
  skip_authorize_resource :only => [:access_denied]


  # GET /users
  # GET /users.json
  def index
    # for partial generic views
    @title_user = "All Catstagram Users"
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @title = "Photos uploaded by " + @user.username
    @title_cat = "Cats belonging to " + @user.username
    # for partial generic views
    @photos = @user.photos
    @cats = @user.cats
  end

  # GET /users/1/edit
  def edit
  end

  # GET /users/banned
  # same as index but only banned users.
  def banned
    authorize! :change_banned, @current_user
    if !current_user.is_admin?
      format.html {redirect_to users_path, alert: "You can't see banned people."}
    else 
      @users = User.all.select{ |u| u.is_banned }
      @title_user = "Banned Users"
      render 'index'
    end
  end


  # GET /users/1/ban
  # Automatically renders ban.html.erb
  def ban
    authorize! :change_banned, @user
    if current_user == @user
      redirect_to @user, alert: "You can't ban yourself!"
    else 
      render 'ban'
    end
  end

  # PATCH/PUT /users/1/ban
  # PATCH/PUT /users/1.json/ban
  # Allows the update of banned_until field 
  def ban_update
    authorize! :change_banned, @user
    respond_to do |format|
      if current_user == @user
        format.html {redirect_to @user, alert: "You can't ban yourself!"}
      elsif @user.update(ban_params)
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
    authorize! :manage, Role
  end

  def save_roles
    authorize! :manage, Role
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

  def access_denied
    #304 rendering.
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      # automatically add user right when we see the user
      # /!\ it add to every and single user visited!
      if !@user.is_user?
        @user.roles << Role.where(name: 'user').first_or_create
      end
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
