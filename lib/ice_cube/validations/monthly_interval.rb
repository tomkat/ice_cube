module IceCube

  module Validations::MonthlyInterval

    # CHANGE
    def interval(interval = 1, rule_times)
      validations_for(:interval) << Validation.new(interval, rule_times)
      clobber_base_validations(:month)
      self
    end

    class Validation

      # CHANGE
      attr_reader :interval, :rule_times

      def type
        :month
      end

      def build_s(builder)
        builder.base = interval == 1 ? 'Monthly' : "Every #{interval} months"
      end

      def build_ical(builder)
        builder['FREQ'] << 'MONTHLY'
        unless interval == 1
          builder['INTERVAL'] << interval
        end
      end

      # CHANGE
      def build_hash(builder)
        builder[:interval] = interval
        builder[:rule_times] = rule_times 
      end

      # CHANGE
      def initialize(interval, rule_times = [])
        @interval = interval
        @rule_times = rule_times
      end

      def validate(time, schedule)
        start_time = schedule.start_time
        months_to_start = (time.month - start_time.month) + (time.year - start_time.year) * 12
        unless months_to_start % interval == 0
          interval - (months_to_start % interval)
        end
      end

    end

  end

end
