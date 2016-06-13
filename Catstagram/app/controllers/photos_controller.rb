class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :like_update, :report_update]

  # Load authorization ressources for everything.
  load_and_authorize_resource :except => [:index_main]

  # Like & report authorization are manually handled! BE CARFEFUL!
  skip_authorize_resource :only => [:like, :report, :reset]

  #======================================================================
  ## WARNING - LIKE & REPORT & RESET ARE OPEN TO ALL USER WITH THESE RIGHTS!
  ## DO NOT TRUST USER INPUT / DO NOT MODIFY OTHER THINGS IN THE PHOTO.
  # Moreover, its impossible to restrict a user to like/report/reser it own photo with cancancan
  # (as the owner has full rights over the photo...) but we do it programmatically in the reply!
  def like
    authorize! :like_photo, @photo

    if current_user != @photo.user
      @photo.increment!(:like_count, 1)
      render 'update_likes.js'
    end

    # respond_to do |format|
    #   if current_user == @photo.user
    #     format.html {redirect_to @photo, notice: "You can't like your own photo, you narcissistic self-obsessed user!"}
    #   else
    #     @photo.increment!(:like_count, 1)
    #     format.html {redirect_to @photo, notice: "Thank you for the like <3"}
    #   end
    # end
  end

  def report
    authorize! :report_photo, @photo
    respond_to do |format|
      if current_user == @photo.user
        format.html {redirect_to @photo, alert: "Cannot report your own photo, unfortunately."}
      else
        @photo.increment!(:report_count, 1)
        format.html {redirect_to @photo, notice: "Report sent"}
      end
    end
  end

  def reset
    authorize! :reset_report_photo, @photo
    respond_to do |format|
      if current_user == @photo.user
        format.html {redirect_to @photo, alert: "Cannot reset report on your own picture..."}
      else
        @photo.update_attribute(:report_count, 0)
        format.html {redirect_to @photo, notice: "Report value reset"}
      end
    end
  end

  # same as index, but only for the admin, and only reported photos.
  def reported
    #ordered by report count, then by most recent
    @photos = Photo.where("report_count > 0").order(report_count: :desc, created_at: :desc)
    if (@photos.size > 0)
      @title = "Reported photos"
    else
      @title = "No reported photos"
    end
    render 'index'
  end

  #======================================================================
  # DEFAULT REST METHODS

  # GET /photos
  # GET /photos.json
  def index
    # most recent picture first!
    @title = "Latest photos"
    @photos = Photo.all.order(created_at: :desc)
  end

  def index_main
    # most recent picture first!
    @title = "Latest Photos"
    @photos = Photo.all.order(created_at: :desc).limit(8)
    @hashtags = Hashtag.all.order(created_at: :desc).limit(4)
    @users = User.all.order(created_at: :desc).limit(4)
    @cats = Cat.all.order(created_at: :desc).limit(4)
    @title_user = "Latest Users"
    @title_tag = "Latest Hashtags"
    @title_cat = "Latest Cats"
    render 'layouts/index'
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo.increment!(:view_count, 1)
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user

    set_tags

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    set_tags

    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_tags
      tags_param = params[:hashtags]

      @hashtags = []
      if tags_param
        tags_param.each do |t|
          unless t.blank?
            tag = t.downcase
            current = Hashtag.find_by(tag: tag)
            if current
              p "loading existing: " + tag
              @hashtags.push(current)
            else
              p "creating new: " + tag
              tag = Hashtag.create(:tag => tag)
              @hashtags.push(tag)
            end
          end
        end
      end

      @photo.hashtags = @hashtags.uniq
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image_url, :caption,
                                    :cat_ids => [],
                                    :hashtags => [])
    end
end
