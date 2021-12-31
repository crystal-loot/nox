module ColorizeHelper
  # I'm always proud to link to stackoverflow when I finally get the chance to copy/paste code from there
  # https://stackoverflow.com/questions/16032726/removing-color-decorations-from-strings-before-writing-them-to-logfile
  def decolorize(str : String) : String
    str.gsub(/\e\[(\d+)(;\d+)*m/, "")
  end
end
