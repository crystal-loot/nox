class Nox::InterceptingIO < IO
  @@names = [] of String

  def initialize(@wrapped : IO, @name : String)
    @@names << @name
  end

  def read(slice : Bytes)
    raise "don't call this"
  end

  def write(slice : Bytes) : Nil
    @name.ljust(max_name_size)
    result = String.build do |str|
      str << @name.ljust(max_name_size)
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
