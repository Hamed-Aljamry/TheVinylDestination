require 'rspotify/oauth'

Rails.application.config.to_prepare do
  RSpotify::authenticate(ENV['51302eaf378e4018a925c35e23ec25b5'], ENV['54705cde78e347739ed9df87ef37011d'])
end
