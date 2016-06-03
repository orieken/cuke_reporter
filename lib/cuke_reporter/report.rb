module CukeReporter
  class Report
    def initialize(json_dir, template_path, report_output)
      @json = join_json_files_in(json_dir)
      @template_path = template_path
      @output_file = report_output

      compile_run_attributes
    end

    def join_json_files_in(json_dir)
      Dir[File.join(json_dir, '*.json')].map { |f| JSON.parse(File.read(f)) unless f.nil? || File.zero?(f) }.flatten
    end

    def make_report(run_duration='00:00')
      engine = Haml::Engine.new(File.read(@template_path))
      File.open(@output_file, 'w') do |file|
        file.puts engine.render(Object.new, {:@features => @json,
                                             :@results => result_distribution,
                                             :@run_result => run_result,
                                             :@run_duration => run_duration})
      end
    end

    def run_result
      if @all_results.include?('failed')
        'failed'
      elsif @all_results.include?('undefined')
        'undefined'
      else
        'passed'
      end
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

      @json.each do |file|
        scenario = CukeReporter::Parser.new(file)
        @all_results.push(scenario.result)
        @all_durations.push(scenario.duration)
      end
    end
  end
end