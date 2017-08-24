module CukeReporter
  class QuickView

    def create(quick_view_template, report_output_dir, report_output, results_data)
      engine = Haml::Engine.new(File.read(quick_view_template))
      File.open("#{report_output_dir}/#{report_output}", 'w') do |file|
        file.puts engine.render(Object.new, {:@results => results_data})
      end
    end

    def get_reports(data_dir)
      report_dirs = []
      Dir.glob(data_dir + '**/*').select { |dir| report_dirs << dir if File.directory?(dir) }
      report_dirs
    end

    def get_results_data(report_dirs, full_report_template, report_output_dir)
      results_data = []
      if report_dirs
        report_dirs.each do |report_dir|
          report_name = get_report_name(report_dir)
          report_output = report_output_name(report_name)
          report_output_path = "#{report_output_dir}/#{report_output}"

          built_report = CukeReporter::Report.new(report_dir, full_report_template, report_output_path)

          results = OpenStruct.new(built_report.result_distribution)
          results.path = report_output
          results.name = report_name
          results.status = built_report.run_result
          results_data << results

          built_report.make_report
        end
      end

      results_data
    end

    def get_report_name(report_dir)
      report_dir.split('/').last
    end

    def report_output_name(report_name)
      report_name + '.html'
    end

  end
end
