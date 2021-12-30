require "../src/nox"
require "spectator"
require "./helpers/**"

Spectator.configure do |config|
  config.randomize
  config.after_each do
    Nox::InterceptingIO.reset!
  end
end
