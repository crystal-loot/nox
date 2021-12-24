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
    print_bold "Starting with pid of #{process.pid}"
    process.wait
    print_bold "Done"
    @process = nil
  end

  def interrupt
    if process = @process
      print_bold "Attempting to interrupt..."
      process.signal(Signal::INT)
    end
  end

  def kill
    if process = @process
      print_bold "Attempting to kill..."
      process.signal(Signal::KILL)
    end
  end

  private def print_bold(str : String) : Nil
    @output.print str.colorize.bold.to_s
  end
end
