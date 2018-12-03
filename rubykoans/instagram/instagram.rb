require 'colorize'
require "instagram"
require "open-uri"

Instagram.configure do |config|
  config.client_id = "6ac037c05bc14f8bb562da8ef1fda749"
  config.client_secret = "e3df00034f074ea18a9e92365049422f"
  # For secured endpoints only
  #config.client_ips = '<Comma separated list of IPs>'
end

CALLBACK_URL = "http://www.archimedianet.it"

puts Instagram.authorize_url(:redirect_uri => CALLBACK_URL)

puts "Inserire l'atoken"
atoken = gets.chomp

response = Instagram.get_access_token(atoken, :redirect_uri => CALLBACK_URL)

atoken =  response.access_token

client = Instagram.client( :access_token => atoken )

user = client.user

for media_item in client.user_recent_media
  img = media_item.images.thumbnail.url

  open(img) {|f|
     File.open("Immagini/Immagine.jpg","wb") do |file|
       file.puts f.read
       puts "Un'immagine è stata scaricata"
     end
  }
end
