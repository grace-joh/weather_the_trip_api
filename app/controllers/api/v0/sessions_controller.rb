class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    return render_unauthorized_response unless user&.authenticate(params[:password])

    render json: UsersSerializer.new(user), status: 200
  end

  private

  def render_unauthorized_response
    render json: { error: 'Invalid email or password' }, status: 401
  end
end
