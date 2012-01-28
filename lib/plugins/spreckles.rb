# = Spreckles
#
# Provides Sprockets support for Jekyll.
#
# Author:: Tom Scott
module Jekyll
  require 'sprockets'
  class StylesheetConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /css|scss|/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      begin
        puts "Performing Sass Conversion."
        engine = Sass::Engine.new(content, :syntax => :scss, :load_paths => ["./css/"])
        engine.render
      rescue StandardError => e
        puts "!!! SASS Error: " + e.message
      end
    end
  end

  class JavascriptConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /scss|css|js|/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      begin
        puts "Performing Sass Conversion."
        engine = Sass::Engine.new(content, :syntax => :scss, :load_paths => ["./css/"])
        engine.render
      rescue StandardError => e
        puts "!!! SASS Error: " + e.message
      end
    end
  end

end
