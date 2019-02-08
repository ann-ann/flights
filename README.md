# README

Checkout setting up flights data at lib/tasks/setup_flights_data.rake

get all flights:
curl -i -H "Accept: application/json" "localhost:3000/api/v1/flights"


get preferred flight:
curl -i -H "Accept: application/json"  -X GET "localhost:3000/api/v1/flights/prefered_flight" -d 'flight[preferences]=FR&flight[min_date]=2015-06-01T21:21:17.274Z&flight[max_date]=2018-06-01T21:21:17.274Z&flight[min_duration]=10&flight[max_duration]=3000&flight[max_distance]=100000'

