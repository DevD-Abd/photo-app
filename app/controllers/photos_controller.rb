class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photo, only: [ :show, :edit, :update, :destroy ]
  before_action :check_owner, only: [ :edit, :update, :destroy ]

  def index
    @photos = current_user.photos.order(created_at: :desc)
    @all_photos = Photo.includes(:user, image_attachment: :blob).order(created_at: :desc).limit(20)
  end

  def show
  end

  def new
    @photo = current_user.photos.build
  end

  def create
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      redirect_to @photo, notice: "Photo was successfully uploaded!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: "Photo was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice: "Photo was successfully deleted!"
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def check_owner
    redirect_to photos_path, alert: "Not authorized!" unless @photo.user == current_user
  end

  def photo_params
    params.require(:photo).permit(:title, :description, :image)
  end
end
