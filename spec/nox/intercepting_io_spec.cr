require "../spec_helper"

Spectator.describe Nox::InterceptingIO do
  include ColorizeHelper

  it "applies the given name to each line of output with a color" do
    wrapped = IO::Memory.new
    intercepting_io = Nox::InterceptingIO.new(wrapped, "foo")

    intercepting_io.print("line 1\nline 2")

    expect(decolorize(wrapped.to_s)).to eq("foo | line 1\nfoo | line 2\n")
  end

  it "adjusts padding of name based on largest one" do
    wrapped = IO::Memory.new
    intercepting_io = Nox::InterceptingIO.new(wrapped, "foo")
    Nox::InterceptingIO.new(wrapped, "longer_name")

    intercepting_io.print("hello")

    expect(decolorize(wrapped.to_s)).to eq("foo         | hello\n")
  end

  it "applies a different color for each name" do
    wrapped = IO::Memory.new
    foo_io = Nox::InterceptingIO.new(wrapped, "foo")
    bar_io = Nox::InterceptingIO.new(wrapped, "bar")

    foo_io.print("hello")
    bar_io.print("world")
    output = wrapped.to_s

    expect(output).to contain("foo".colorize(:cyan).to_s)
    expect(output).to contain("bar".colorize(:yellow).to_s)
  end

  it "handles carriage returns" do
    wrapped = IO::Memory.new
    intercepting_io = Nox::InterceptingIO.new(wrapped, "foo")

    intercepting_io.print("line 1 - 1%\rline 1 - 2%")

    expect(decolorize(wrapped.to_s)).to eq("foo | line 1 - 1%\rfoo | line 1 - 2%\n")
  end
end
