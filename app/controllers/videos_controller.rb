class VideosController < ApplicationController
  before_action :set_video, only: %i[ show edit update destroy add_to_favourite remove_from_favourite]
  before_action :authenticate_user!, only: [:add_to_favourite, :remove_from_favourite, :show_all_fav_videos]

  # GET /videos or /videos.json
  def index
    @videos = Video.all
    if user_signed_in?
      @user_fav_video_ids = (fav_video_ids)
    end
  end

  def show_all_fav_videos
    @videos = Video.all
    @user_fav_videos = (fav_video_ids)
  end

  # GET /videos/1 or /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos or /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: "Video was successfully created." }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1 or /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: "Video was successfully updated." }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1 or /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: "Video was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_to_favourite
    UserFavouriteVideo.create(user_id: current_user.id, video_id: @video.id)
    respond_to do |format|
      format.html { redirect_to videos_url, notice: "Video was successfully added to your favourite list." }
    end  
  end

  def remove_from_favourite
    UserFavouriteVideo.find_by(user_id: current_user.id, video_id: @video.id).destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: "Video was successfully removed from your favourite list." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :yt_url, :description)
    end

    def fav_video_ids
      current_user.user_favourite_videos.pluck(:video_id)
    end
end
