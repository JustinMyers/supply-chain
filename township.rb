# class Good
#   attr_reader :name
# end

class Good
  attr_reader :name, :inputs, :output, :time, :factory

  def initialize(name, inputs, output, time, factory, sell_price = 0)
    @name = name
    @inputs = inputs
    @output = output
    @time = time # in seconds
    @factory = factory
  end
end

coin = Good.new(:coin, [], [:coin, 1], 1, :bank)

wheat = Good.new(:wheat, [], [:wheat, 1], 120, :field)
corn = Good.new(:corn, [[:coin, 1]], [:corn, 1], 300, :field)
strawberry = Good.new(:strawberry, [[:coin, 5]], [:strawberry, 1], 3600, :field)

cow_feed = Good.new(:cow_feed, [[:wheat, 2], [:corn, 1]], [:cow_feed, 3], 300, :feed_mill)
milk = Good.new(:milk, [[:cow_feed, 1]], [:milk, 1], 1200, :cowshed)
bread = Good.new(:bread, [[:wheat, 2]], [:bread, 1], 300, :bakery)
butter = Good.new(:butter, [[:milk, 3]], [:butter, 1], 3600, :dairy)

sandwich = Good.new(:sandwich, [[:bread, 1], [:butter, 1], [:strawberry, 2]], [:sandwich, 1], 2400, :fast_food_restaurant)

@factories = [coin, wheat, corn, bread, milk, cow_feed, butter, strawberry, sandwich]

@concurrent = [:field, :feed_mill]

@timeline = []

def calculate(output)
  time = {}

  factory = @factories.find { |p| p.output.first == output }

  time[factory.factory] ||= 0

  time[factory.factory] += time[factory.factory] + factory.time

  factory.inputs.each do |input|
    input.last.times do
      t = calculate(input.first)
      time = sum_time(t, time)
    end
  end

  time
end

def sum_time(a, b)
  a.each_pair do |k, v|
    if @concurrent.include?(k)
      b[k] ||= []
      b[k] = b[k] + Array(v)
    else
      b[k] ||= 0
      b[k] += v
    end
  end
  b
end

def in_minutes(hash)
  hash.each_pair do |factory, minutes|
    hash[factory] = Array(minutes).reduce(:+) / 60 unless factory == :bank
  end
end

puts in_minutes(calculate(:sandwich))
