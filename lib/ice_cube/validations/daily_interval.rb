module IceCube

  module Validations::DailyInterval

    # Add a new interval validation
    # CHANGE
    def interval(interval, rule_times)
      validations_for(:interval) << Validation.new(interval, rule_times)
      clobber_base_validations(:wday, :day)
      self
    end

    # A validation for checking to make sure that a time
    # is inside of a certain DailyInterval
    class Validation

      # CHANGE
      attr_reader :interval, :rule_times

      # CHANGE
      def initialize(interval, rule_times)
        @interval = interval
        @rule_times = rule_times
      end

      # CHANGE
      def build_s(builder)
        description = interval == 1 ? 'Daily' : "Every #{interval} days"
        rule_times.each do |rule_time|
          description << " from #{ rule_time[:start_time].strftime('%H:%M:%S') } to #{ rule_time[:end_time].strftime('%H:%M:%S') } and"
        end
        builder.base = description.chomp(' and')
      end

      # CHANGE
      def build_hash(builder)
        builder[:interval] = interval
        builder[:rule_times] = rule_times 
      end

      def build_ical(builder)
        builder['FREQ'] << 'DAILY'
        unless interval == 1
          builder['INTERVAL'] << interval
        end
      end

      def type
        :day
      end

      def validate(time, schedule)
        time_date = Date.new(time.year, time.month, time.day)
        start_date = Date.new(schedule.start_time.year, schedule.start_time.month, schedule.start_time.day)
        days = time_date - start_date
        unless days % interval === 0
          interval - (days % interval)
        end
      end

    end

  end

end
