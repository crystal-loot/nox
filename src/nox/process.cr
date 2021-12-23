class Nox::Process
  @process : ::Process?

  def initialize(@procfile_entry : Nox::Procfile::Entry, @dir : String, @output : IO)
  end

  def run
    process = @process = ::Process.new(
      @procfile_entry.command,
      output: @output,
      error: @output,
      shell: true,
      chdir: @dir
    )
    process.wait
  end

  def interrupt
    @process.try &.signal(Signal::INT)
  end

  def kill
    @process.try &.signal(Signal::KILL)
  end
end
