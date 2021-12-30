struct Nox::Procfile
  ENTRY_REGEX = /^([\w-]+):\s+(.+)$/

  def self.parse_file(file : String) : self
    parse(File.read(file))
  end

  def self.parse(content : String) : self
    proc_file = new
    content.each_line do |line|
      match_data = ENTRY_REGEX.match(line).not_nil!
      proc_file.entries << Nox::Procfile::Entry.new(match_data[1], match_data[2])
    end
    proc_file
  end

  getter entries = [] of Nox::Procfile::Entry

  struct Entry
    getter process_type : String
    getter command : String

    def initialize(@process_type, @command)
    end
  end
end
