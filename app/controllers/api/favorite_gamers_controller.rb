class Api::FavoriteGamersController < ApplicationController
  def create
    if !params[:user_id] || !params[:company_id]
      render json: {
        error: 'Please provide the proper params: user_id: integer and company_id: integer'
      },
             status: 422
      return
    end
    @favorite = FavoriteGamer.new(favorite_params)
    @company = Company.find(@favorite.company_id)
    if @favorite.save
      render json: {
        success: 'The gamer was favorited successfully',
        company: {
          name: @company.name,
          email: @company.email,
          location: @company.location,
          favorite_gamers: @company.users
        }
      },
             status: 200
    else
      render json: {
        error: @favorite.errors.full_messages
      },
             status: 422
    end
  end

  def delete
    if !params[:id]
      render json: {
        error: 'Please provide the proper params: id: integer'
      },
             status: 422
      return
    end
    @favorite = FavoriteGamer.find(params[:id])
    if @favorite
      @favorite.delete
      render json: {
        success: 'The gamer was unfavorited successfully'
      },
             status: 200
    else
      render json: {
        error: 'It was not possible to unfavorite this gamer at the time'
      },
             status: 422
    end
  end

  private

  def favorite_params
    params.permit(:user_id, :company_id)
  end
end
