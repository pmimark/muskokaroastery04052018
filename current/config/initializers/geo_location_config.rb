#unless GeoLocation == nil
if defined?(GeoLocation) == 'constant' && GeoLocation.class == Class
  # Use Hostip (free)
  GeoLocation::use = :hostip

  # HostIP example:
  #
  # location = GeoLocation.find('24.24.24.24') # => { :ip => "24.24.24.24", :city => "Liverpool", :region => "NY", :country => "United States", :country_code => "US", :latitude => "43.1059", :longitude => "-76.2099", :timezone => "America/New_York" }
  #
  # puts location[:ip] # => 24.24.24.24
  # puts location[:city] # => Liverpool
  # puts location[:region] # => NY
  # puts location[:country] # => United States
  # puts location[:country_code] # => US
  # puts location[:latitude] # => 43.1059
  # puts location[:longitude] # => -76.2099
  # puts location[:timezone] # => America/New_York

  # User Max Mind (paid)
  # For more information visit: http://www.maxmind.com/app/city
  #
  # GeoLocation::use = :maxmind
  # GeoLocation::key = 'YOUR MaxMind.COM LICENSE KEY'
end
