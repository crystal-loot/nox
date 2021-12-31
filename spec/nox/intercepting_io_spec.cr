require "../spec_helper"

Spectator.describe Nox::InterceptingIO do
  it "applies the given name to each line of output with a color" do
    wrapped = IO::Memory.new
    intercepting_io = Nox::InterceptingIO.new(wrapped, "foo")

    intercepting_io.print("line 1\nline 2")

    expect(wrapped.to_s.lines).to contain_exactly(
      "#{"foo".colorize(:cyan)} | line 1",
      "#{"foo".colorize(:cyan)} | line 2"
    )
  end

  it "adjusts padding of name based on largest one" do
    wrapped = IO::Memory.new
    intercepting_io = Nox::InterceptingIO.new(wrapped, "foo")
    Nox::InterceptingIO.new(wrapped, "longer_name")

    intercepting_io.print("line 1\nline 2")

    expect(wrapped.to_s.lines).to contain_exactly(
      "#{"foo".colorize(:cyan)}         | line 1",
      "#{"foo".colorize(:cyan)}         | line 2"
    )
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
end
