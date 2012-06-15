module IceCube

  class WeeklyRule < ValidatedRule

    include Validations::WeeklyInterval

    # CHANGE
    def initialize(interval = 1, week_start = :sunday, rule_times)
      interval(interval, week_start, rule_times)
      schedule_lock(:wday, :hour, :min, :sec)
    end

    # CHANGE
    def get_rule_times
	    @validations[:interval].first.rule_times
    end

  end

end