require "../spec_helper"

Spectator.describe Nox::Procfile do
  include ProcfileHelper

  describe ".parse" do
    it "parses each line into an entry" do
      content = <<-PROCFILE
      web: crystal src/app.cr
      frontend: yarn start
      PROCFILE

      result = Nox::Procfile.parse(content)

      expect(result.entries).to contain_exactly(
        procfile_entry("web", "crystal src/app.cr"),
        procfile_entry("frontend", "yarn start")
      )
    end
  end
end
