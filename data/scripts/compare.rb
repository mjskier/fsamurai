#!/usr/bin/env ruby

f = []
c = []

ARGF.each do |line|
  f << "#{$1.to_i} #{$2.to_i} #{$3.to_i}" if
    line =~ /u:\s+(\d+\.\d+)\s+v:\s+(\d+\.\d+)\s+w:\s+(\d+\.\d+)/
  c << "#{$1} #{$2} #{$3}" if
    line =~ /u:\s+(\d+),\s+v:\s+(\d+),\s+w:\s+(\d+)/
end

puts "Entries: #{f.size}"

(0..(f.size - 1)).each do |i|
  puts "at #{i} < #{f[i]}  > #{c[i]}" if(f[i] != c[i])
end

    
