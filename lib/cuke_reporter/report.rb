module CukeReporter
  class Report
    def initialize(json_dir, template_path, report_output)
      @files = join_json(json_dir)
      @template_path = template_path
      @output_file = report_output

      compile_run_attributes
      # binding.pry
    end

    def join_json(json_dir)
      Dir[json_dir].map { |f| JSON.parse File.read(f) }.flatten
    end

    def say_hi
      p 'hi'
    end

    def make_report(run_duration='00:00')
      engine = Haml::Engine.new(File.read(@template_path))
      File.open(@output_file, 'w') do |file|
        file.puts engine.render(Object.new, {:@scenarios => @files,
                                          :@results => result_distribution,
                                          :@run_result => run_result,
                                          :@run_duration => run_duration})
      end
    end

    def run_result
      return 'failed' if @all_results.include?('failed')
      return 'undefined' if @all_results.include?('undefined')

      #At this point all the scenario has passed
      'failed'
    end

    def result_distribution
      {
          total: @all_results.count,
          passed: @all_results.grep('passed').count,
          failed: @all_results.grep('failed').count,
          undefined: @all_results.grep('undefined').count
      }
    end

    private
    def compile_run_attributes
      @all_results = []
      @all_durations = []

      @files.each do |file|
        scenario = CukeReporter::Parser.new(file)
        @all_results.push(scenario.result)
        @all_durations.push(scenario.duration)
      end
    end
  end
end