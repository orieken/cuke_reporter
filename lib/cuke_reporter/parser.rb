module CukeReporter
  class Parser
    attr_reader :feature, :result, :duration

    def initialize(feature)
      @feature = RecursiveOpenStruct.new(feature, :recurse_over_arrays => true )
      @feature.scenarios = @feature.elements
      @result = get_result
      @duration = get_duration
    end

    private

    def get_duration
      duration = 0

      @feature.scenarios.each do |scenarios|
        scenarios.steps.each do |step|
          duration += step.result.duration
        end
      end
      duration
    end


    def get_result
      results = []

      @feature.scenarios.each do |scenario|
        scenario_results = []
        scenario.steps.each do |step|
          scenario_results << step.result.status
          results << step.result.status
        end
        scenario.status = get_status(scenario_results)
      end
      get_status(results)
    end

    def get_status(results)

      if results.include?('failed')
        'failed'
      elsif results.include?('undefined')
        'undefined'
      else
        'passed'
      end
    end

  end
end