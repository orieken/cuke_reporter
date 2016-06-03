module CukeReporter
  class Parser
    attr_reader :feature, :result, :duration

    def initialize(feature)
      @feature = RecursiveOpenStruct.new(feature, :recurse_over_arrays => true)
      @feature.scenarios = @feature.elements
      @result = get_result
      @duration = get_duration
    end

    private

    def get_duration
      duration = 0

      if @feature.scenarios
        @feature.scenarios.each do |scenarios|
          scenarios.steps.each do |step|
            duration += step.result.duration if step.result.duration
          end
        end
      end
      duration
    end


    def get_result
      results = []

      if @feature.scenarios
        @feature.scenarios.each do |scenarios|
          scenarios.steps.each do |step|
            results << step.result.status
          end
        end
      end

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