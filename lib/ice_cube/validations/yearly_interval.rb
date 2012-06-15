module IceCube

  module Validations::YearlyInterval

    # CHANGE
    def interval(interval = 1, rule_times)
      validations_for(:interval) << Validation.new(interval, rule_times)
      clobber_base_validations(:year)
    end

    class Validation

      # CHANGE
      attr_reader :interval, :rule_times

      def type
        :year
      end

      # CHANGE
      def build_s(builder)
        description = interval == 1 ? 'Yearly' : "Every #{interval} years"
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
        builder['FREQ'] << 'YEARLY'
        unless interval == 1
          builder['INTERVAL'] << interval
        end
      end

      # CHANGE
      def initialize(interval, rule_times = [])
        @interval = interval
        @rule_times = rule_times
      end

      def validate(time, schedule)
        years_to_start = time.year - schedule.start_time.year
        unless years_to_start % interval == 0
          interval - (years_to_start % interval)
        end
      end

    end

  end

end
