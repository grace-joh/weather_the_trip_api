class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    return render_unauthorized_response unless user

    road_trip = RoadTripFacade.new(params[:origin], params[:destination]).get_road_trip
    render json: RoadTripSerializer.new(road_trip), status: 201
  end

  def render_unauthorized_response
    render json: { error: 'Unauthorized' }, status: 401
  end

  # private

  # def user_params
  #   params.permit(:origin, :destination, :api_key)
  # end
end
