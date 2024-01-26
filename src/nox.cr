require "colorize"
require "./nox/procfile"
require "./nox/intercepting_io"
require "./nox/process"
require "./nox/runner"

module Nox
  VERSION = "0.2.2"

  def self.run(file : String)
    procfile = Nox::Procfile.parse_file(file)
    runner = Nox::Runner.new(procfile, output: STDOUT)
    {% if compare_versions(Crystal::VERSION, "1.8.0") < 0 %}
      {% raise "Windows requires >= 1.8.0" if flag?(:win32) %}
      Signal::INT.trap { runner.interrupt_or_kill }
    {% else %}
      ::Process.on_interrupt { runner.interrupt_or_kill }
    {% end %}
    runner.run
  end
end
