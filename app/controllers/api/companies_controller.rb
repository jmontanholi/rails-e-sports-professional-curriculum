class Api::CompaniesController < ApplicationController
  def sign_in
    @companies = Company.find_by(email: params[:email])
    if @companies && @companies.password == params[:password]
      render json: {
        company: {
          name: @companies.name,
          email: @companies.email,
          location: @companies.location,
          favorite_gamers: @companies.users
        }
      },
             status: 200
    elsif @companies && @companies.password != params[:password]
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
    @companies = Company.new(company_params)
    if @companies.save
      render json: {
        company: {
          name: @companies.name,
          email: @companies.email,
          location: @companies.location,
          favorite_gamers: @companies.favorite_gamers
        }
      },
             status: 200
    else
      render json: {
        errors: @companies.errors.full_messages
      },
             status: 422
    end
  end

  def delete
    @companies = Company.find_by(email: params[:email])
    if @companies && @companies.password == params[:password]
      @companies.delete
      render json: {
        success: 'The company was successfully deleted'
      },
             status: 200
    elsif @companies && @companies.password != params[:password]
      render json: {
        error: 'The email or the password is wrong'
      },
             status: 422
    else
      render json: {
        error: 'No company was found with that email'
      },
             status: 404
    end
  end

  def company_params
    params.permit(
      :email,
      :password,
      :location,
      :name,
      :favorite_gamers
    )
  end
end
