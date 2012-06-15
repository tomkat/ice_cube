module IceCube

  class MonthlyRule < ValidatedRule

    include Validations::MonthlyInterval

    # CHANGE
    def initialize(interval = 1, rule_times)
      interval(interval, rule_times)
      schedule_lock(:day, :hour, :min, :sec)
    end

    # CHANGE
    def get_rule_times
      @validations[:interval].first.rule_times
    end

  end

end
