require 'thor'
require 'pry'
require_relative '../../cuke_reporter'



module CukeReporter
  class ReportGenerator < Thor::Group
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__)
    end

    desc 'Creates Cucumber Reports structure'
    def create_report

      copy_file('templates/jquery-2.1.1.min.js','foo/javascripts/jquery-2.1.1.min.js')
      copy_file('templates/toggle_header.js','foo/javascripts/toggle_header.js')
      copy_file('templates/report.css','foo/stylesheets/report.css')

      directory('templates/bootstrap-3.2.0-dist', 'foo/stylesheets/bootstrap-3.2.0-dist')

      data_dir = CukeReporter::ReportGenerator.source_root + '/../../../json/*.json'

      report_template = CukeReporter::ReportGenerator.source_root + '/templates/report.haml'
      report_output = 'foo/index.html'

      report = CukeReporter::Report.new(data_dir, report_template, report_output)
      say 'Generating Report…', :green
      report.make_report

    end
  end
end
