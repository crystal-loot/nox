class Nox::Runner
  private getter done = Channel(Nil).new
  private getter processes : Array(Nox::Process)

  def initialize(procfile : Nox::Procfile, @output = STDOUT)
    @processes = procfile.entries.map { |entry| Nox::Process.new(entry, dir: Dir.current, output: @output) }
  end

  def run
    @output.puts "Nox starting processes..."
    processes.each do |process|
      spawn do
        process.run
        done.send(nil)
      end
    end

    processes.size.times do
      done.receive
    end

    puts "ALL DONE!"
  end

  def interrupt
    processes.each(&.interrupt)
  end
end
