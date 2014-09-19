require 'thor'
require_relative 'report_generator'

module CukeReporter
  class Generators < Thor
    register(CukeReporter::ReportGenerator, 'create_report', 'create_report', 'Creates the basic structure for generating the Cucumber Report')
  end
end