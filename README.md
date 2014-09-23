CukeReporter
=============

Stand alone report generator that will take cucumber json output and create a single report.

# CukeReporter

CukeReporter takes json output like from:

```sh
cucumber -f json -o myfile.json
```

and creates a report from it using bootstrap you can build your own template and css no need to use what we have made see Usage below

If you use cukeforker as long as all the json output is in the same directory CukeReporter will munge the files together and make one report

If you have multiple directories with multiple json files in them. quick_view will create a report for each 
child directory and create a report that has a the results of all the individual reports  


## Installation

Add this line to your application's Gemfile:

    gem 'cuke_reporter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cuke_reporter

## Usage

```sh
cuke_reporter help

Commands:
  cuke_reporter create_report [DATA_DIR]  # Creates the basic Cucumber Report from multiple Cucumber json files
  cuke_reporter help [COMMAND]            # Describe available commands or one specific command
  cuke_reporter quick_view [DATA_DIR]     # Creates a Quick view of multiple reports

```

```sh
cuke_reporter help create_report
Usage:
  cuke_reporter create_report [DATA_DIR]

Options:
  [--css], [--no-css]                  
                                       # Default: true
  [--report-template=REPORT_TEMPLATE]  
                                       # Default:  cuke_reporter/generators/templates/report.haml
  [--report-output=REPORT_OUTPUT]      
                                       # Default: cucumber_report.html

Creates the basic Cucumber Report from multiple Cucumber json files
```

```sh
./bin/cuke_reporter help quick_view
Usage:
  cuke_reporter quick_view [DATA_DIR]

Options:
  [--css], [--no-css]                            
                                                 # Default: true
  [--quick-view-template=QUICK_VIEW_TEMPLATE]    
                                                 # Default:  cuke_reporter/generators/templates/quick_view.haml
  [--full-report-template=FULL_REPORT_TEMPLATE]  
                                                 # Default: cuke_reporter/generators/templates/report.haml
  [--report-output=REPORT_OUTPUT]                
                                                 # Default: quick_view.html

Creates a Quick view of multiple reports
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/cuke_reporter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
