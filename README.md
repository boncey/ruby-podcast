## Podcast is a simple library and command line utility for creating podcast files from a directory of mp3 files.
Podcast will examine mp3s, extract metadata from ID3 tags, and build an RSS file which can then be podcast clients to download the mp3s.

### To build and install ruby-podcast

You'll need to install the Ruby mp3info library installed before podcast
will work:

    gem install ruby-mp3info

Or you can grab ruby-mp3info here:

    http://rubyforge.org/projects/ruby-mp3info/

Then get the ruby-podcast source:

    git clone https://github.com/boncey/ruby-podcast.git - or [download](https://github.com/boncey/ruby-podcast/archive/master.zip)
    cd ruby-podcast
    gem build podcast.gemspec
    gem install podcast-*.gem (this may need a sudo prefix depending on your ruby setup)

### Usage

Once you've installed ruby-mp3info and podcast you should have a 
command line utility you can run on a directory of mp3 files:

    % podcast --dir my/mp3/dir --out podcast.rss --title "Title" --description "Description" --link http://mypodcastserver/

#### Please note
This used to be hosted at http://podcast.rubyforge.org/
However, that version no longer works with newer versions of Ruby.

I (https://github.com/boncey) have made changes so it to works and after getting no answer from the author or via the list on rubyforge have decided to upload my version to https://github.com/boncey/ruby-podcast
