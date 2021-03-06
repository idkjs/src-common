# Pseudo random number generator
# From: http://gnuvince.wordpress.com/2005/11/24/pseudo-random-number-generator
# Author: Vincent Foley-Bourgon

def random_number
  t = Time.now.to_f / (Time.now.to_f % Time.now.to_i)
  random_seed = t * 1103515245 + 12345
  (random_seed / 65536) % 32768
end

10.times { puts random_number }

cnt = Array.new(10,0)
20000.times { cnt[(random_number % 10).to_i] += 1 }
p cnt
puts


# Ruby Gaussian Random Number Generator
# Author: Glenn
# http://webhost101.net/rails/typo/articles/2007/07/31/ruby-gaussian-random-number-generator

def gaussian_rand
   u1 = u2 = w = g1 = g2 = 0  # declare
   begin
     u1 = 2 * rand - 1
     u2 = 2 * rand - 1
     w = u1 * u1 + u2 * u2
   end while w >= 1

   w = Math::sqrt( ( -2 * Math::log(w)) / w )
   g2 = u1 * w
   g1 = u2 * w
   # g1 is returned
end

sum = 0
sumsq = 0
n = 1000
0.upto(n) do
  #r = gaussian_rand
  r = gaussian_rand * 100 + 50   # new_random_number = gaussian_rand * standard_deviation + average
  #puts r
  sum += r
  sumsq += (r*r)
end

ave = sum/n
stddev = Math::sqrt(sumsq/n - ave * ave)
puts "Average = #{ave}"
puts "StdDev = #{stddev}"
puts
