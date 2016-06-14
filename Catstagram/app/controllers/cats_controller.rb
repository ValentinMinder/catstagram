class CatsController < ApplicationController
  before_action :set_cat, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource :except => [:index]

  # GET /cats
  # GET /cats.json
  def index
    @title_cat = "All Catstagram Cats"
    @cats = Cat.all
  end

  # GET /cats/1
  # GET /cats/1.json
  def show
    @title = "Photos of this cat"
    # for partial generic views
    @photos = @cat.photos
  end

  # GET /cats/new
  def new
    @cat = Cat.new
  end

  # GET /cats/1/edit
  def edit
  end

  # POST /cats
  # POST /cats.json
  def create
    @cat = Cat.new(cat_params)
    # cleaning an empty user_id with a nil value in db
    if (cat_params[:user_id] == 'on' or cat_params[:user_id] == 0)
      @cat.update_attribute(:user_id, nil)
    end

    respond_to do |format|
      if @cat.save
        format.html { redirect_to @cat, notice: 'Cat was successfully created.' }
        format.json { render :show, status: :created, location: @cat }
      else
        format.html { render :new }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cats/1
  # PATCH/PUT /cats/1.json
  def update
    # cleaning an empty user_id with a nil value in db
    if (cat_params[:user_id] == 'on' or cat_params[:user_id] == 0)
      @cat.update_attribute(:user_id, nil)
      respond_to do |format|
        if @cat.update(cat_params_noid)
          format.html { redirect_to @cat, notice: 'Cat was successfully updated.' }
          format.json { render :show, status: :ok, location: @cat }
        else
          format.html { render :edit }
          format.json { render json: @cat.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @cat.update(cat_params)
          format.html { redirect_to @cat, notice: 'Cat was successfully updated.' }
          format.json { render :show, status: :ok, location: @cat }
        else
          format.html { render :edit }
          format.json { render json: @cat.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /cats/1
  # DELETE /cats/1.json
  def destroy
    @cat.destroy
    respond_to do |format|
      format.html { redirect_to cats_url, notice: 'Cat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cat
      @cat = Cat.find(params[:id])
      # cat as a profile photo defined by the last uploaded photo
      if @cat.photos.any? 
        @profile_photo = @cat.photos.last
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cat_params
      params.require(:cat).permit(:catname, :description, :city, :birth_time, :user_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cat_params_noid
      params.require(:cat).permit(:catname, :description, :city, :birth_time)
    end
end
