# Just some examples of how IceCube (ice_cube gem) can be used.

$LOAD_PATH << './lib'

require 'ice_cube.rb'
include IceCube
require 'pp'

def output(instance)
  puts "\n#{instance.to_s} (#{instance.class.name})"
  puts "~~~~~~~~~~~~~~~~~~~~"
  puts "to_hash: " 
  pp instance.to_hash

  puts "\n.to_yaml: " 
  puts instance.to_yaml
  puts '~~~~~~~~~~~~~~~~~~~~'
end


# The fridays in October that are on the 13th of the month
schedule = Schedule.new(Time.new(2012, 5, 1, 8, 00))
rule1 = Rule.weekly(1, :sunday, [{:start_time => Time.new(2012, 5, 2, 9, 00), :end_time => Time.new(2012, 5, 2, 12, 00)}, {:start_time => Time.new(2012, 5, 2, 13, 00), :end_time => Time.new(2012, 5, 2, 18, 00)}]).day(:friday)
#rule2 = Rule.weekly(1, :sunday, [{:start_time => Time.new(2012, 5, 2, 9, 50), :end_time => Time.new(2012, 5, 2, 12, 00)}]).day(:friday)
#rule2 = Rule.weekly(1, :sunday, [{:start_time => Time.new(2012, 5, 2, 9, 00), :end_time => Time.new(2012, 5, 2, 12, 00)}]).day(:friday)
rule2 = Rule.weekly(1, :sunday, [{:start_time => Time.new(2012, 5, 2, 9, 50), :end_time => Time.new(2012, 5, 2, 12, 00)}]).day(:thursday)
#rule2 = Rule.weekly(1, :sunday).day(:thursday)


#rule1 = Rule.weekly(1, :sunday).day(:friday)
#rule2 = Rule.weekly(1, :sunday).day(:thursday)
 
schedule.add_recurrence_rule rule1
schedule.add_recurrence_rule rule2
output(schedule)
#puts schedule.occurrences(Time.new(2012, 5, 30, 9, 0)).inspect
puts schedule.occurrences(Time.new(2012, 5, 30, 9, 0), :start_time => Time.new(2012, 5, 2, 10, 00), :end_time => Time.new(2012, 5, 2, 12, 00)).inspect

# rule = Rule.yearly.day_of_week(:monday => [2, -1]).month_of_year(:april)
# schedule = Schedule.new(Time.now)
# schedule.add_recurrence_rule rule
# output(schedule)

# ten = Time.new(2010, 5, 15, 10, 0, 0)
# schedule = Schedule.new(Time.now, :duration => 3600)
#schedule = Schedule.new(ten, :duration => 3600)
#weekly_thursdays = Rule.weekly.day(:thursday)
#schedule.add_recurrence_rule weekly_thursdays
#output(schedule)

# puts schedule.inspect
# puts rule.inspect
#puts schedule.first(10).inspect
# puts schedule.first.inspect
# puts schedule.all_occurrences.inspect

# Create a schedule for every day in May
# schedule = Schedule.new(Time.now)
# schedule.add_recurrence_rule Rule.daily.month_of_year(:may)

# output(weekly_thursdays)

# schedule = Schedule.new(ten, :end_time => ten + 30)
# weekly_thursdays = Rule.weekly.day(:thursday)
# puts "Rule class: #{weekly_thursdays.class.name}"
# puts "Rule Ancestors: #{weekly_thursdays.class.ancestors}"
# puts "Rule is instance of IceCube:Rule? #{weekly_thursdays.instance_of? IceCube::Rule}"
# puts "Rule is kind of IceCube:Rule? #{weekly_thursdays.kind_of? IceCube::Rule}"

# schedule.add_recurrence_rule weekly_thursdays
# output(schedule)
# puts schedule.all_occurrences.inspect