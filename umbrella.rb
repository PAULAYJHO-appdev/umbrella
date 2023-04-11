p "Where are you located?"
user_location = gets.chomp
# user_location = "Chicago"

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch("GMAPS_KEY")}"

# p gmaps_url

require "open-uri"
raw_response = URI.open(gmaps_url).read

# p raw_response

require "json"
parsed_response = JSON.parse(raw_response)

#p parsed_response

results_array = parsed_response.fetch("results")
first_result = results_array.at(0)

geo = first_result.fetch("geometry")

loc =geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

# p latitude
# p longitude
puts "Your coordinates are #{latitude}, #{longitude}."

#Assemble the correct Pirate Weather URL using the above values
#Read, parse, and print the current temperature

pirate_weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{latitude},#{longitude}"

# p pirate_weather_url

raw_pirate_weather_data = URI.open(pirate_weather_url).read

parsed_pirate_weather_data = JSON.parse(raw_pirate_weather_data)

current_hash = parsed_pirate_weather_data.fetch("currently")

current_temp = current_hash.fetch("temperature")

puts "It is currently #{current_temp}°F."


hour_hash = parsed_pirate_weather_data.fetch("hourly")

hourly_data_array = hour_hash.fetch("data")

next_twelve_hours = hourly_data_array[1..12]

# p hour_hash
# p hourly_data_array
# p next_twelve_hours

rain_prob = 0.10

any_rain = false

next_twelve_hours.each do |hour_hash|

  rain_prob_hour = hour_hash.fetch("precipProbability")

  if rain_prob_hour > rain_prob
    any_rain = true

    rain_time = Time.at(hour_hash.fetch("time"))

    seconds_from_now = rain_time - Time.now

    hours_from_now = seconds_from_now / 60 / 60

    puts "In #{hours_from_now.round} hours, there is a #{(rain_prob * 100).round}% chance of precipitation."
  end
end

if any_rain == true
  puts "You might want to take an umbrella!"
else
  puts "You probably won't need an umbrella."
end
