#!/usr/bin/env ruby

# Generate some test data for fsamuari from a given NETCDF file

require 'optparse'

require 'numru/netcdf'
require 'date'
require 'geokit'

include NumRu

class ArgParser < Hash
  def initialize(argv)
    OptionParser.new do |opts|
      opts.banner = 'Usage: gen_input -i <input file>'

      opts.on('-i', '--input NAME', 'Input File') { |v| self[:input] = v }
    end.parse!
  end
  
end

Geokit::default_units = :kms

def calc_dist(lat1,lon1,lat2,lon2)

  position1 = Geokit::LatLng.new(lat1,lon1) 
  position2 = Geokit::LatLng.new(lat2,lon2) 

  distance = position1.distance_to(position2)
  return distance
end

opts = ArgParser.new(ARGV)
unless opts.has_key?(:input)
  puts '-i option is required. Use the -h option for usage'
  exit 1
end

# Read nc-file
file = NetCDF.open(opts[:input])

# ------------------  TO MODIFY ------------------
center_lat = 22
center_lon = -80
maxradius = 1000  # in km

init_year = 2016; init_mon  = 10; init_day  = 9; init_hr   = 15
year = 2016; mon  = 10; day  = 9; hr   = 15

# ------------------  MODIFY END ------------------

# Convert time to seconds and record as time
init_time = DateTime.new(init_year,init_mon,init_day,init_hr)
time = DateTime.new(year,mon,day,hr)
unixtime = time.to_time.to_i.to_s
timestep = ((time-init_time)*24).to_i 

raw_data = Hash.new()
adjusted_data = Hash.new()
dims = ["XTIME","XLAT","XLONG"]
vars = ["U","V","W","T","PH","PHB","P","PB","QVAPOR","REFL_10CM", "PH"]
sfcvars = ["U10","V10","T2","PSFC","Q2"]

dims.each do |dim|
  raw_data[dim] = file.var(dim).get
end

vars.each do |var|
  raw_data[var] = file.var(var).get[true,true,true,timestep]
end

sfcvars.each do |var|
  raw_data[var] = file.var(var).get
end

# Calculate height, total pressure, dry air density and temperature
# Change units of q_vapor from kg/kg to g/kg
puts "Calculating additional variables ..."

size = raw_data["T"].size
rank = raw_data["T"].rank
shape = raw_data["T"].shape
length = raw_data["T"].length

adjusted_vars = ["U", "V", "W", "Z","P_TOT","RHO_A","T","QVAPOR","Z_LINEAR"]
adjusted_vars.each do |var|
  adjusted_data[var] = NArray.float(shape[0],shape[1],shape[2])
end

(0..shape[0]-1).each do |x|
  (0..shape[1]-1).each do |x|
    (0..shape[2]-1).each do |x|
      lat = raw_data["XLAT"][i, j, timestep]
      lon = raw_data["XLONG"][i, j, timestep]
      # More stuff
    end
  end
end
      
puts "Done :)"
exit 0
