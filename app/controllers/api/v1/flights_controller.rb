class Api::V1::FlightsController < ApplicationController

  def index
    @flights = Flight.all
    render json: @flights
  end

  def prefered_flight
    @flight = Flight.prefered_flights(prefered_flight_params)
    render json: @flight
  end

  private

  def prefered_flight_params
    params[:flight]
  end
end
