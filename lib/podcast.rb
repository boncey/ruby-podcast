require 'find'
require 'rss/0.9'
require 'mp3info'
require 'rss/maker'
require 'uri'

module Podcast 

  class Feed

    attr_reader :title, :link, :description, :image, :base, :language, :version, :about
    attr_writer :title, :link, :description, :image, :base, :language, :version, :about

    include Enumerable

    def initialize
      @mp3s = []
      @language = "English"
      @base = ''
    end

    # add an mp3 file to the podcast
    def add_mp3( file )
      mp3 = Mp3File.new( file )
      @mp3s.push( mp3 )
    end

    # add a directory location to the podcast
    # the directory will be recursively search
    # for mp3 files.
    def add_dir( dir )
      # we chdir into the directory so that file paths will be relative
      pwd = Dir.pwd
      Dir.chdir( dir )
      Find.find( '.' ) do |f|
        if ( f =~ /\.mp3$/ && File.size?(f))
          f.sub!( %r{^./}, '' ) # remove leading './'
          add_mp3(f)
        end
      end
      # go back to original directory
      Dir.chdir( pwd )
    end

    # the total amount of files in the podcast
    def size
      @mp3s.size
    end

    # write the podcast file 
    def get_rss
      #version = "1.0" # ["0.9", "1.0", "2.0"]
      version = @version

      content = RSS::Maker.make(version) do |m|
        m.channel.title = @title
        m.channel.description = @description 
        m.channel.link = @link 
        m.channel.language = @language
        m.channel.about = @about
        m.items.do_sort = true # sort items by date

        if @image != nil
          m.image.url = @image
          m.image.title = @title
        end

        for mp3 in @mp3s 
          next if ! mp3.artist
          item = m.items.new_item
          item.title = mp3
          ## add a base url 
          if base != ''
            link = base + '/' + URI::escape(mp3.path)
          else 
            link = URI::escape(mp3.path)
          end
          item.link = link
          item.date = mp3.mtime
          item.enclosure.url = link
          item.enclosure.length = mp3.length
          item.enclosure.type = mp3.type
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

  class Mp3File

    attr_reader :artist, :album, :title, :file, :path, :length, :type, :mtime
    attr_writer :artist, :album, :title, :file, :path, :length, :type, :mtime

    def initialize(f)
      file = File.new(f)
      info = Mp3Info.open(f)
      tag = info.tag()
      @file = f
      @artist = tag['artist']
      @album = tag['album']
      @title = tag['title']
      @path = file.path()
      @length = file.stat.size()
      @mtime = file.stat.mtime()
      @type = 'audio/mpeg'
    end

    def to_s
      @title
    end

  end

end
