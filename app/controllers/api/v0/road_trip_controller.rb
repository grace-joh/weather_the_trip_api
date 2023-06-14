class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    return render_unauthorized_response unless user

    @road_trip = RoadTripFacade.new(params[:origin], params[:destination]).get_road_trip
    render json: RoadTripSerializer.new(@road_trip), status: road_trip_status
  end

  private

  def render_unauthorized_response
    render json: { error: 'Unauthorized' }, status: 401
  end

  def road_trip_status
    return 422 if @road_trip.travel_time == 'impossible route'

    201
  end
end
