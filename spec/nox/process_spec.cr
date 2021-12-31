require "../spec_helper"

Spectator.describe Nox::Process do
  include ProcfileHelper
  include ColorizeHelper

  it "pipes output to passed in IO" do
    io = IO::Memory.new
    entry = procfile_entry("web", "echo hello")
    process = Nox::Process.new(entry, __DIR__, io)

    process.run
    output = decolorize(io.to_s).lines

    expect(output.shift).to match(/web | Starting with pid of \d+/)
    expect(output.shift).to eq("web | hello")
    expect(output.shift).to eq("web | Done")
  end

  it "can be run in a different directory" do
    io = IO::Memory.new
    entry = procfile_entry("web", "pwd")
    process = Nox::Process.new(entry, "./spec", io)

    process.run
    output = decolorize(io.to_s).lines

    expect(output).to contain("web | #{File.join(Dir.current, "spec")}")
  end
end
