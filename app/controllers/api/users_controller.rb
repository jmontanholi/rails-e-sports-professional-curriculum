class Api::UsersController < ApplicationController
  def index
    @users = User.all
    if @users
      render json: {
        users: @users
      },
             status: 200
    else
      render json: {
        error: 'There are no users in the system'
      },
             status: 404
    end
  end

  def sign_in
    @user = User.find_by(email: params[:email])
    if @user && @user.password == params[:password]
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
    elsif @user && @user.password != params[:password]
      render json: {
        error: 'The email or the password is wrong'
      },
             status: 422
    else
      render json: {
        error: 'No user was found with that email'
      },
             status: 404
    end
  end

  def sign_up
    @user = User.new(user_params)
    if @user.save
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
        errors: @user.errors.full_messages
      },
             status: 422
    end
  end

  def delete
    @user = User.find_by(email: params[:email])
    if @user && @user.password == params[:password]
      @user.delete
      render json: {
        success: 'The user was successfully deleted'
      },
             status: 200
    elsif @user && @user.password != params[:password]
      render json: {
        error: 'The email or the password is wrong'
      },
             status: 422
    else
      render json: {
        error: 'No user was found with that email'
      },
             status: 404
    end
  end

  private

  def user_params
    params.permit(
      :email,
      :password,
      :location,
      :name,
      :description,
      :user_type,
      :age
    )
  end
end
