module ProcfileHelper
  def procfile_entry(process_type, command)
    Nox::Procfile::Entry.new(process_type, command)
  end
end
