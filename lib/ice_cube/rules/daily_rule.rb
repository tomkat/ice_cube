module IceCube

  class DailyRule < ValidatedRule

    include Validations::DailyInterval

    def initialize(interval = 1, rule_times)
      interval(interval, rule_times)
      schedule_lock(:hour, :min, :sec)
    end

  end

end
