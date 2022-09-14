require "colorize"
require "./nox/procfile"
require "./nox/intercepting_io"
require "./nox/process"
require "./nox/runner"

module Nox
  VERSION = "0.2.1"

  def self.run(file : String)
    procfile = Nox::Procfile.parse_file(file)
    runner = Nox::Runner.new(procfile, output: STDOUT)
    Signal::INT.trap { runner.interrupt_or_kill }
    runner.run
  end
end
