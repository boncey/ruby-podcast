require 'rubygems'
require 'podcast/version'
require 'find'
require 'rss/0.9'
require 'mp3info'
require 'mp4info'
require 'rss/maker'
require 'uri'

module Podcast 

  class Feed

    attr_reader :title, :link, :description, :image, :base, :language, :version, :about
    attr_writer :title, :link, :description, :image, :base, :language, :version, :about

    include Enumerable

    def initialize
      @podcast_files = []
      @language = "en-us"
      @about = "Made with #{NAME}"
      @base = ''
    end

    # add a podcast file to the podcast
    def add_file(file)
      begin
        podcast_file = PodcastFile.new(file)
        @podcast_files.push(podcast_file)
      rescue Exception => e
        puts "Skipping #{file} as it has a problem: #{e}"
      end
    end

    def valid?
      title != nil && description != nil && link != nil
    end

    # add a directory location to the podcast
    # the directory will be recursively search
    # for media files.
    def add_dir(dir)
      # we chdir into the directory so that file paths will be relative
      pwd = Dir.pwd
      Dir.chdir(dir)
      Find.find('.') do |f|
        if (File.file?(f) && File.size?(f))
          f.sub!(%r{^./}, '') # remove leading './'
          add_file(f)
        end
      end
      # go back to original directory
      Dir.chdir(pwd)
    end

    # the total amount of files in the podcast
    def size
      @podcast_files.size
    end

    # write the podcast file 
    def get_rss
      #version = "1.0" # ["0.9", "1.0", "2.0"]
      version = @version

      content = RSS::Maker.make(@version) do |m|
        m.channel.title = @title
        m.channel.description = @description 
        m.channel.link = @link 
        m.channel.language = @language
        m.channel.about = @about
        m.items.do_sort = true # sort items by date
        m.channel.updated = Time.now.to_s
        m.channel.author = NAME

        if @image != nil
          m.image.url = @image
          m.image.title = @title
        end

        for podcast_file in @podcast_files
          item = m.items.new_item
          item.title = podcast_file
          ## add a base url 
          if base != ''
            link = base + '/' + URI::escape(podcast_file.path)
          else 
            link = URI::escape(podcast_file.path)
          end
          item.link = link
          item.date = podcast_file.mtime
          item.enclosure.url = link
          item.enclosure.length = podcast_file.length
          item.enclosure.type = podcast_file.type
        end
      end

      return content
    end

    def each
      @songs.each do |s|
        yield s
      end
    end

  end

  class PodcastFile

    attr_reader :artist, :album, :title, :file, :path, :length, :type, :mtime
    attr_writer :artist, :album, :title, :file, :path, :length, :type, :mtime

    def initialize(file_path)

      # Universal values, regardless of media type
      file = File.new(file_path)
      @path = file.path()
      @length = file.stat.size()
      @mtime = file.stat.mtime()

      # Media-specific values.
      if file_path =~ /mp3$/ then
        info = Mp3Info.open(file_path)
        tag = info.tag()
        @type = 'audio/mpeg'
        @artist = tag['artist']
        @album = tag['album']
        @title = tag['title']
      elsif file_path =~ /mp4$/ then
        info = MP4Info.open(file)
        @type = 'video/mp4'
        @artist = info.ART() ? info.ART() : "ARTIST"
        @album = info.ALB() ? info.ALB() : "ALBUM"
        @title = info.NAM()  ? info.NAM() : "TITLE"
      else
        raise 'Unknown file type. Skipping!'
      end
    end

    def to_s
      @title
    end

  end

end
