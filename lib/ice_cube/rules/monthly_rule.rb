module IceCube

  class MonthlyRule < ValidatedRule

    include Validations::MonthlyInterval

    def initialize(interval = 1, rule_times)
      interval(interval, rule_times)
      schedule_lock(:day, :hour, :min, :sec)
    end

  end

end
