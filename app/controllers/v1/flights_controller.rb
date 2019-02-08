class V1::FlightsController < ApplicationController

  def index
    @flights = Flight.all
    render json: @flights
  end
end
