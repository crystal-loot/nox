class Nox::InterceptingIO < IO
  COLORS = [
    Colorize::ColorANSI::Cyan,
    Colorize::ColorANSI::Yellow,
    Colorize::ColorANSI::Green,
    Colorize::ColorANSI::Magenta,
    Colorize::ColorANSI::Red,
    Colorize::ColorANSI::Blue,
    Colorize::ColorANSI::LightCyan,
    Colorize::ColorANSI::LightYellow,
    Colorize::ColorANSI::LightGreen,
    Colorize::ColorANSI::LightMagenta,
    Colorize::ColorANSI::LightRed,
    Colorize::ColorANSI::LightBlue,
  ]

  @@names = [] of String

  @color : Colorize::ColorANSI

  def initialize(@wrapped : IO, @name : String)
    @@names << @name
    idx = @@names.size - 1
    @color = COLORS[idx % COLORS.size]
  end

  def read(slice : Bytes)
    raise "don't call this"
  end

  def write(slice : Bytes) : Nil
    lines = String.build(&.write(slice)).split(/(?<=[\n\r])/)
    lines.pop if lines.last.blank?
    lines.each do |line|
      result = String.build do |str|
        str << @name.ljust(max_name_size + 1).sub(@name, @name.colorize(@color).to_s)
        str << "| "
        str << line
        if !line.ends_with?(/[\n\r]/)
          str << "\n"
        end
      end
      @wrapped.print(result)
    end
  end

  private def max_name_size : Int32
    @@names.max_of(&.size)
  end
end
