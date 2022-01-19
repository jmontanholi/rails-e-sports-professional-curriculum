class Api::VideosController < ApplicationController
  def create
    @video = Video.new(video_params)
    @user = User.find(@video.user_id)
    if @video.save
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
        error: @video.errors.full_messages
      },
             status: 422
    end
  end

  def delete
    @video = Video.find(params[:id])
    if @video
      @video.delete
      render json: {
        success: 'The video was deleted successfully'
      },
             status: 200
    else
      render json: {
        error: 'It was not possible to delete this video at the time'
      },
             status: 422
    end
  end

  private

  def video_params
    params.permit(:link, :user_id, :video_type)
  end
end
