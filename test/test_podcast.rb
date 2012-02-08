#!/usr/bin/env ruby

$LOAD_PATH.unshift('lib')
require 'test/unit'
require 'rubygems'
require 'podcast'

class PodcastTest < Test::Unit::TestCase

  def test_constructor
    p = Podcast::Feed.new
    assert(p.class == Podcast::Feed)
  end

  def test_add_mp3
    p = Podcast::Feed.new
    p.add_mp3('test/test.mp3')
    p.add_mp3('test/test.mp3')
    p.add_mp3('test/test.mp3')
    assert_equal(p.size(), 3)
  end

  def test_add_bad_mp3
    p = Podcast::Feed.new
    p.add_mp3('test/test.mp3')
    p.add_mp3('test/test.mp3')
    p.add_mp3('test/bad.mp3')
    assert_equal(p.size(), 2)
  end

  def test_add_dir
    p = Podcast::Feed.new
    p.add_dir('.')
    assert_equal(p.size(), 1)
  end

  def test_get_rss
    p = Podcast::Feed.new
    p.title = 'test podcast'
    p.description = 'test podcast coming at ya'
    p.link = 'http://www.example.org'
    p.image = 'http://www.example.org/icon.png'
    p.base = 'http://www.example.org/torrents'
    ## add using directory so we can confirm it is stripped
    p.add_dir('test') 
    p.version = "0.9"
    xml = p.get_rss().to_s

    # parse the rss
    parser = RSS::Parser.new('0.9')
    rss = RSS::Parser.parse(xml)
    items = rss.items()
    assert(items.size == 1)
    assert_equal(items[0].link, 'http://www.example.org/torrents/test.mp3')
  end

end
