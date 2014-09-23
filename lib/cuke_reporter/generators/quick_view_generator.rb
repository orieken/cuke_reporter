require_relative '../../cuke_reporter'


module CukeReporter
  class QuickViewGenerator < Thor::Group
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__)
    end

    argument :data_dir, required: true
    argument :report_output_dir, :default => 'cucumber_report'

    class_option :css, type: :boolean, default: true
    class_option :quick_view_template, type: :string, default: CukeReporter::ReportGenerator.source_root + '/templates/quick_view.haml'
    class_option :full_report_template, type: :string, default: CukeReporter::ReportGenerator.source_root + '/templates/report.haml'
    class_option :report_output, type: :string, :default => 'quick_view.html'

    desc 'Creates a Quick view of multiple reports'

    def quick_view

      if  File.directory?(data_dir)
        if options[:css] == false
          say 'skipping css', :red
        else
          say 'adding css', :green
          copy_file('templates/report.css', "#{report_output_dir}/stylesheets/report.css")
          directory('templates/bootstrap-3.2.0-dist', "#{report_output_dir}/stylesheets/bootstrap-3.2.0-dist")
        end

        say 'adding javascript', :green
        copy_file('templates/jquery-2.1.1.min.js', "#{report_output_dir}/javascripts/jquery-2.1.1.min.js")
        copy_file('templates/toggle_header.js', "#{report_output_dir}/javascripts/toggle_header.js")

        say 'Generating report...', :green
        quick_view = QuickView.new
        report_dirs = quick_view.get_reports(data_dir)
        results_data = quick_view.get_results_data(report_dirs, options[:full_report_template], report_output_dir)

        quick_view.create(options[:quick_view_template], report_output_dir, options[:report_output], results_data)

        if File.exists?("#{report_output_dir}/#{options[:report_output]}")
          say 'Report generated successfully', :green
        else
          say 'something went wrong', :red
        end

      else
        say 'data_dir must be a path', :red
      end

    end

  end
end
