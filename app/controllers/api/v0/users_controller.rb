class Api::V0::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create
    if params[:password] == params[:password_confirmation]
      user = User.create!(user_params)
      render json: UsersSerializer.new(user), status: 201
    else
      render json: { error: 'Passwords do not match' }, status: 401
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def render_unprocessable_entity_response(exception)
    render json: { error: exception.message }, status: 422
  end
end
