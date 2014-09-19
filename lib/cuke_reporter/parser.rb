module CukeReporter
  class Parser
    attr_reader :tags, :steps, :result, :duration

    def initialize(filename)
      @json = filename
      @scenario = @json['elements'].first
      @steps = get_steps
      @result = get_result
      @duration = get_duration
      @tags = get_tags unless @scenario['tags'].nil?
    end

    def feature_name
      @json['name'].gsub('-', ' ').capitalize
    end

    def feature_description
      @json['description'].split("\n").reject! { |x| x.empty? }
    end

    def feature_file
      @json['uri']
    end

    def scenario_description
      @scenario['description']
    end

    def scenario_name
      @scenario['name']
    end

    def scenario_location
      "#{@json['uri']}:#{@scenario['line']}"
    end

    private

    def get_tags
      tags = []
      @scenario['tags'].each do |tag|
        tags.push(tag['name'])
      end
      tags
    end

    def get_duration
      duration = 0
      @steps.each do |s|
        duration += s[:duration]
      end
      duration
    end

    def get_steps
      steps = []
      @scenario['steps'].each do |step|
        steps.push(
            {name: "#{step['keyword']} #{step['name']}".split.join(" "),
             line: step['line'],
             duration: step['result']['duration'].to_i/1000000000,
             result: step['result']['status'],
             match: step['match']['location'],
             error: step['result']['error_message']
            }
        )
      end
      steps
    end

    def get_result
      results = []
      @steps.each do |s|
        results.push(s[:result])
      end

      return 'failed' if results.include?('failed')
      return 'undefined' if results.include?('undefined')

      #At this point the scenario has passed
      'passed'
    end
  end
end