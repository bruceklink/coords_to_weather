require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather
    @address = params[:address]

    @url_safe_address = "http://maps.googleapis.com/maps/api/geocode/json?address=" + URI.encode(@address) + "&sensor=false"


    # Your code goes here.
    url_2 = @url_safe_address
    raw_data_2 = open(url_2).read
    parsed_data_2 = JSON.parse(raw_data_2)
    results = parsed_data_2["results"]
    first = results[0]
    geometry = first["geometry"]
    location = geometry["location"]
    @latitude = location["lat"]
    @longitude = location["lng"]
   

    #@latitude = 42.0538387
    #@longitude = -87.67721
    your_api_key = "dac657549d816cc1fba08b9a14656e65"

    # Your code goes here.
    url = "https://api.forecast.io/forecast/" + your_api_key + "/#{@latitude},#{@longitude}"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    @temperature = parsed_data["currently"]["temperature"]
    @minutely_summary = parsed_data["minutely"]["summary"]
    @hourly_summary = parsed_data["hourly"]["summary"]
    @daily_summary = parsed_data["daily"]["summary"]
  end
end
