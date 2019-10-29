class Api::V1::FlightsController < ApplicationController

  def index
    @flights = Flight.all
    render json: @flights
  end

  def prefered_flight
    @flight = Flight.prefered_flight(*prepare_flight_params)
    render json: @flight
  end

  private

  def prepare_flight_params
    [
      flight_params[:preferences],
      flight_params[:min_date].to_datetime,
      flight_params[:max_date].to_datetime,
      flight_params[:min_duration],
      flight_params[:max_duration],
      flight_params[:max_distance]
    ]
  end

  def flight_params
    params
      .require(:flight)
      .permit(:preferences, :min_date, :max_date, :min_duration, :max_duration, :max_distance)
  end
end
