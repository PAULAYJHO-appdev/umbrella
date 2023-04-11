p "Where are you located?"
user_location = gets.chomp
# user_location = "Chicago"

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=AIzaSyB92cYxPcYqgjwBJfWlwDQw_7yjuyU3tpA"

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

p latitude
p longitude

#Assemble the correct Pirate Weather URL using the above values
#Read, parse, and print the current temperature
