## Ruby-podcast: generate audio/video podcast from the command line

This project provides a command line utility `podcast` which can generate
an RSS feed for Podcasts. When you publish this file, and give it to iTunes
or Overcast users, it'll let them to fetch and listen to your files.

`podcast` supports both audio and video podcast. Currently supported file
extensions are `mp3` and `mp4`.  Podcast will examine these files, extract
metadata from ID3 tags, and build an RSS file which can then be used by
podcast clients to download the mp3s.

### To install ruby-podcast

    gem install ruby-podcast

### Usage

Once you've installed it you should have a 
command line utility you can run on a directory of your media files:

    % podcast --dir test/ --out podcast.rss --title "Title" --description % "Description" --link http://mypodcastserver/ --image bleh

To quickstart, we've provided 2 Rake tasks for quick bootstrapping:

	% rake test1

and:

	% rake test2

First should print the RSS feed content on the standard output. The 2nd will
create an RSS file in the current directory.

### Contributing

Clone this repo. Then after you make some modifications, try to run the
`podcast` through `bundle`:

	% bundle exec ./bin/podcast --dir test/ --title t --description desc --link link --image bleh

#### Please note

This used to be hosted at http://podcast.rubyforge.org/
However, that version no longer works with newer versions of Ruby.

I, [boncey](https://github.com/boncey), have fixed it and created a new project at https://rubygems.org/gems/ruby-podcast
