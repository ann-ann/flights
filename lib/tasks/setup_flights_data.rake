require 'loc'
require 'net/http'
require 'json'

namespace :flights do
  task setup_flights_data: :environment do

    #get our flights data
    uri = URI('https://gist.githubusercontent.com/bgdavidx/132a9e3b9c70897bc07cfa5ca25747be/raw/8dbbe1db38087fad4a8c8ade48e741d6fad8c872/gistfile1.txt')
    flights_data = JSON.parse(Net::HTTP.get(uri))


    #load data about airpots
    airports_data = JSON.parse(Net::HTTP.get(URI("https://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588/airports.json")))


    # we will fill out our flights table
    flights_data.each do |data|
      origin = airports_data.select {|s| s['code'] == data['origin']}.first
      destination = airports_data.select {|s| s['code'] == data['destination']}.first

      loc1 = Loc::Location[origin['lat'].to_f, origin['lon'].to_f]
      loc2 = Loc::Location[destination['lat'].to_f, destination['lon'].to_f]

      distance = loc1.distance_to(loc2).round(2)
      departure_time = data['departureTime'].to_datetime
      arrival_time = data['arrivalTime'].to_datetime
      duration_in_minutes = ((arrival_time - departure_time) * 24 * 60).to_i

      Flight.create(
        departure_time: departure_time,
        arrival_time: arrival_time,
        carrier: data['carrier'],
        origin: data['origin'],
        destination: data['destination'],
        distance: distance,
        duration: duration_in_minutes
      )
    end
  end
end