class Nox::Runner
  private getter done = Channel(Nil).new
  private getter processes : Array(Nox::Process)

  def initialize(procfile : Nox::Procfile)
    @processes = procfile.entries.map { |entry| Nox::Process.new(entry, dir: Dir.current, output: STDOUT) }
  end

  def run
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
