class Flight < ApplicationRecord

  CARRIER_PREF_MULTIPLIER = 0.9

  # example Flight.prefered_flights('FR', 10.years.ago, Time.now, 10, 300000, 1000000)
  scope :prefered_flights, -> (preferences, min_date, max_date, min_duration, max_duration, max_distance){
    where(carrier: preferences)
    .where("departure_time > ? AND departure_time < ?", min_date, max_date)
    .where("duration > ? AND duration < ?", min_duration, max_duration)
    .where('distance < ?', max_distance)
    .select('flights.*, duration * 0.9 + distance AS prefered')
    .order('prefered').limit(1)
  }




  # def get_preferred_flight(preferences, minDate, maxDate, minDuration, maxDuration, maxDistance)
  #   (Flight Duration) * (Carrier Preference) + (Distance between Source and Destination)



  # end
end