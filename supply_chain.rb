@barn = {}

@log = []

class Good
  attr_reader :name, :inputs, :output, :time, :factory
  
  def initialize( name, inputs, output, time, factory, sell_price = 0 )
    @name = name
    @inputs = inputs
    @output = output
    @time = time # in seconds
    @factory = factory
  end
end

# {
#   fast_food_restaurant: { 40 => [ { item: sandwich, quantity: 1, time: 40 } ] },
#   bakery: { 45 => { item: bread, quantity: 1, time: 5 } }
# }

class Queue
  attr_reader :concurrent, :queue
  
  @queue = {}
  
  def initialize( concurrent )
    @concurrent = concurrent
  end
  
  def add_good( time_done_by, item, quantity, time_required )
    start_time = time_done_by + time_required

    if @concurrent
      @queue[ start_time ] ||= []
      @queue[ start_time ] << { item: item, quantity: quantity, time: time_required }
    else
      if @queue.keys.detect { |time| time > time_done_by && time < start_time }
        # there is something in the way
        
        
    end
  end
end

coin = Good.new(:coin, [], [:coin, 1], 1, :bank )
wheat = Good.new(:wheat, [], [:wheat, 1], 120, :field)
corn = Good.new(:corn, [[:coin, 1]], [:corn, 1], 300, :field )
strawberry = Good.new(:strawberry, [[:coin, 5]], [:strawberry, 1], 3600, :field )
cow_feed = Good.new(:cow_feed, [[:wheat, 2], [:corn, 1]], [:cow_feed, 3], 300, :feed_mill )
milk = Good.new(:milk, [[:cow_feed, 1]], [:milk, 1], 1200, :cowshed )
bread = Good.new(:bread, [[:wheat, 2]], [:bread, 1], 300, :bakery)
butter = Good.new(:butter, [[:milk, 3]], [:butter, 1], 3600, :dairy)
sandwich = Good.new(:sandwich, [[:bread, 1], [:butter, 1], [:strawberry, 2]], [:sandwich, 1], 2400, :fast_food_restaurant)

@goods = [coin, wheat, corn, strawberry, 
          cow_feed, milk, bread, butter, sandwich]

@concurrent = [:field, :feed_mill, :cowshed]

class Factory
end

# t0 = moment when final product is available.

