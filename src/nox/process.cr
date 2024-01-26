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
  end

  def interrupt
    with_process do |process|
      print_bold "Attempting to interrupt..."
      process.signal(Signal::INT)
    end
  end

  def kill
    with_process do |process|
      print_bold "Attempting to kill..."
      {% if compare_versions(Crystal::VERSION, "1.8.0") < 0 %}
        {% if flag?(:win32) %}
          process.terminate
        {% else %}
          process.signal(Signal::KILL)
        {% end %}
      {% else %}
        process.terminate(graceful: false)
      {% end %}
    end
  end

  private def with_process
    if (process = @process) && process.exists?
      yield process
    end
  end

  private def print_bold(str : String) : Nil
    @output.print str.colorize.bold.to_s
  end
end
