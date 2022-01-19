class Api::PhotosController < ApplicationController
  def create
    @photo = Photo.new(photo_params)
    @user = User.find(@photo.user_id)
    if @photo.save
      render json: {
        user: {
          name: @user.name,
          email: @user.email,
          description: @user.description,
          age: @user.age,
          location: @user.location,
          photos: @user.photos,
          videos: @user.videos
        }
      },
             status: 200
    else
      render json: {
        error: @photo.errors.full_messages
      },
             status: 422
    end
  end

  def delete
    @photo = Photo.find(params[:id])
    if @photo
      @photo.delete
      render json: {
        success: 'The photo was deleted successfully'
      },
             status: 200
    else
      render json: {
        error: 'It was not possible to delete this photo at the time'
      },
             status: 422
    end
  end

  private

  def photo_params
    params.permit(:link, :user_id, :photo_type)
  end
end
