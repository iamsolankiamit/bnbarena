module Paperclip
  class Watermark < Thumbnail
    # Handles watermarking of images that are uploaded.
    attr_accessor :format, :whiny, :watermark_path, :position

    def initialize file, options = {}, attachment = nil
      super
      @file             = file
      @whiny            = options[:whiny].nil? ? true : options[:whiny]
      @format           = options[:format]
      @watermark_path   = options[:watermark_path]
      @position         = options[:watermark_position].nil? ? "NorthEast" : options[:watermark_position]

      @current_format   = File.extname(@file.path)
      @basename         = File.basename(@file.path, @current_format)
    end

    # Performs the conversion of the +file+ into a watermark. Returns the Tempfile
    # that contains the new image.
    def make
      return @file unless watermark_path

      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode

      command = "composite"
      params = "-dissolve 50% -gravity #{@position} -geometry +1+30 #{watermark_path} #{fromfile} #{tofile(dst)}"

      begin
        success = Paperclip.run(command, params)
      rescue PaperclipCommandLineError
        raise PaperclipError, "There was an error processing the watermark for #{@basename}" if @whiny
      end

      dst
    end

    def fromfile
      "\"#{ File.expand_path(@file.path) }[0]\""
    end

    def tofile(destination)
      "\"#{ File.expand_path(destination.path) }[0]\""
    end
  end
end
