# README

Checkout setting up flights data at lib/tasks/setup_flights_data.rake

get all flights:
curl -i -H "Accept: application/json" "localhost:3000/api/v1/flights"


get preferred flight:
curl -i -H "Accept: application/json"  -X GET "localhost:3000/api/v1/flights/prefered_flight" -d 'flight[preferences]=FR&flight[min_date]=2015-06-01T21:21:17.274Z&flight[max_date]=2018-06-01T21:21:17.274Z&flight[min_duration]=10&flight[max_duration]=3000&flight[max_distance]=100000'



QUESTION 2:
1.

CREATE TABLE public.airlines (
    id bigint NOT NULL,
    name character varying NOT NULL,
    abbr character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.airports (
    id bigint NOT NULL,
    name character varying NOT NULL,
    iata_code character varying NOT NULL,
    address character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.flights (
    id bigint NOT NULL,
    airline_id bigint,
    origin_airport_id bigint,
    destination_airport_id bigint,
    duration integer NOT NULL,
    distance integer NOT NULL,
    price integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

2.
SELECT "flights".*
FROM "flights"
INNER JOIN "airports" ON "airports"."id" = "flights"."origin_airport_id"
INNER JOIN "airports" "destination_airports_flights" ON "destination_airports_flights"."id" = "flights"."destination_airport_id"
WHERE (airports.iata_code = 'VIE'
       AND destination_airports_flights.iata_code = 'JFK')
ORDER BY "flights"."duration" ASC
LIMIT 1

4. flight speed = distance / duration.
SELECT airlines.name,
       max(avg_speed_meters_per_second) AS max_avg_speed_meters_per_second
FROM
  (SELECT airline_id,
          CAST (distance AS FLOAT)/duration AS avg_speed_meters_per_second
   FROM flights
   GROUP BY airline_id,
            distance,
            duration) AS airline_flights
JOIN "airlines" ON "airlines"."id" = "airline_flights"."airline_id"
GROUP BY airlines.name
ORDER BY max_avg_speed_meters_per_second DESC
LIMIT 1;s
