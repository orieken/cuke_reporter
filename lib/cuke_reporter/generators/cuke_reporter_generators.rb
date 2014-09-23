require 'thor'
require 'thor/runner'
require_relative 'report_generator'
require_relative 'quick_view_generator'

module CukeReporter
  class Generators < Thor
    register(CukeReporter::ReportGenerator, 'create_report', 'create_report [DATA_DIR]', 'Creates the basic Cucumber Report from multiple Cucumber json files')
    register(CukeReporter::QuickViewGenerator,'quick_view', 'quick_view [DATA_DIR]', 'Creates a Quick view of multiple reports')

    tasks['create_report'].options = CukeReporter::ReportGenerator.class_options
    tasks['quick_view'].options = CukeReporter::QuickViewGenerator.class_options
  end
end