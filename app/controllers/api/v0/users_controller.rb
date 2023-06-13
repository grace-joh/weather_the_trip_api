class Api::V0::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create
    return render_unprocessable_content_response unless params[:password] == params[:password_confirmation]

    user = User.create!(user_params)
    render json: UsersSerializer.new(user), status: 201
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def render_unprocessable_entity_response(exception)
    render json: { error: exception.message }, status: 422
  end

  def render_unprocessable_content_response
    render json: { error: 'Passwords do not match' }, status: 401
  end
end
