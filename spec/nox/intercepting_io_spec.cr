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
end
