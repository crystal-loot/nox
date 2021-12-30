class Nox::InterceptingIO < IO
  # clear the names so we can test padding and color reliably
  def self.reset!
    @@names.clear
  end
end
