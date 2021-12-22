class Nox::Runner
  getter done = Channel(Nil).new

  def initialize(@procfile : Nox::Procfile)
  end

  def run
    processes = @procfile.entries.map { |entry| Nox::Process.new(entry, dir: Dir.current) }
    processes.each do |process|
      spawn do
        process.run
        done.send(nil)
      end
    end

    processes.size.times do
      done.receive
    end
  end
end
