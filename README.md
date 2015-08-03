## Podcast is a simple library and command line utility for creating podcast files from a directory of mp3 files.
Podcast will examine mp3s, extract metadata from ID3 tags, and build an RSS file which can then be used by podcast clients to download the mp3s.

### To install ruby-podcast

    gem install ruby-podcast

### Usage

Once you've installed it you should have a 
command line utility you can run on a directory of mp3 files:

    % podcast --dir my/mp3/dir --out podcast.rss --title "Title" --description "Description" --link http://mypodcastserver/

#### Please note
This used to be hosted at http://podcast.rubyforge.org/
However, that version no longer works with newer versions of Ruby.

I, [boncey](https://github.com/boncey), have fixed it and created a new project at https://rubygems.org/gems/ruby-podcast
