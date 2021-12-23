class Nox::InterceptingIO < IO
  COLORS = [2, 3, 4, 5, 6, 42, 130, 103, 129, 108]

  @@names = [] of String

  @color : Int32

  def initialize(@wrapped : IO, @name : String)
    @@names << @name
    idx = @@names.size - 1
    @color = COLORS[idx % COLORS.size]
  end

  def read(slice : Bytes)
    raise "don't call this"
  end

  def write(slice : Bytes) : Nil
    result = String.build do |str|
      str << "\033[1;38;5;#{@color}m"
      str << @name.ljust(max_name_size + 1)
      str << "\033[0m| "
      str.write(slice)
      str << '\n'
    end
    @wrapped.write(result.to_slice)
  end

  private def max_name_size : Int32
    @@names.sort.first.size
  end
end
