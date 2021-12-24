class Nox::Process
  @process : ::Process?

  def initialize(@procfile_entry : Nox::Procfile::Entry, @dir : String, output : IO)
    @output = Nox::InterceptingIO.new(output, @procfile_entry.process_type)
  end

  def run
    process = @process = ::Process.new(
      @procfile_entry.command,
      output: @output,
      error: @output,
      shell: true,
      chdir: @dir
    )
    @output.print "Starting with pid of #{process.pid}"
    process.wait
    @output.print "Done"
  end

  def interrupt
    @output.print "Attempting to interrupt..."
    @process.try &.signal(Signal::INT)
  end

  def kill
    @output.print "Attempting to kill..."
    @process.try &.signal(Signal::KILL)
  end
end
