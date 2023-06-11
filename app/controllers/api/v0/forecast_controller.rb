class Api::V0::ForecastController < ApplicationController
  def search
    forecast = ForecastFacade.new(params[:location]).get_forecast
    render json: ForecastSerializer.new(forecast)
  end
end
