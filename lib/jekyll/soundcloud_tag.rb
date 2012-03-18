module Jekyll
  class SoundcloudTag < Liquid::Tag
    def initialize tag_name, text, tokens
      super
      @url = text
    end

    def render context
      case true
      when url_is_track?
        # embed a track code
      when url_is_profile?
        # embed a profile code
      end
    end

    def url_is_track?
      @url.split('/').
  end

  Liquid::Template.register_tag 'sound', Jekyll::SoundcloudTag
end
