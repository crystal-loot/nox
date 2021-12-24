require "../nox"
require "option_parser"

start = false
file = "Procfile"

OptionParser.parse do |parser|
  parser.on("start", "Run a Procfile") do
    start = true
    parser.on("-f PROCFILE", "--file=PROCFILE", "Specify the name of the Procfile to use") { |_file| file = _file }
  end

  parser.on("-h", "--help", "Show help") do
    puts parser
    exit
  end
end

if start
  procfile = Nox::Procfile.parse_file(file)
  runner = Nox::Runner.new(procfile, output: STDOUT)
  Signal::INT.trap { runner.interrupt_or_kill }
  runner.run
end
