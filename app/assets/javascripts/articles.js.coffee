###
Takes a comma-separated list of tags and determines what search engine to place them under based on the tag symbol.

# - Twitter
$ - Stock symbol, searches on Google Finance
` - GitHub
~ - Facebook
? - Wikipedia
###
class TagList
  # Saves the target element in a jQuery object, looks up the tag list
  # from its existing HTML, then renders the new computed HTML to the
  # DOM.
  constructor: (element) ->
    @self = $(element)
    @render _.reduce @self.html().split(","), @toString, ""

  # Render all tags to string.
  toString: (tags, tag) ->
    tags << @renderTag \
              symbol: tag.substr(0, 1)
              param: tag.substr(1).split(" ").join("+")
              raw: tag

  # Filter out last 2 chars if it's just a comma and space.
  render: (tags) ->
    if tags.substr(-2) is ", "
      @self.html tags.substr(0, tags.length - 2) 
    else
      @self.html tags

  # Render a tag to string based on if its first character matches any
  # symbol we listen for.
  renderTag: (tag) ->
    switch tag.symbol
      when "#" # Twitter
        "<a href=\"http://twitter.com/#!/search/#{tag.param}\" class=\"twitter\" title=\"Twitter: #{tag.raw}\">#{tag.raw}</a>, "
      when "$" # Google Finance
        "<a href=\"http://finance.google.com/?q=\" class=\"finance\" title=\"Finance: #{tag.raw}\">#{tag.raw}</a>, "
      when "`" # GitHub
        "<a href=\"http://github.com/search/?q=#{tag.param}\" class=\"github\" title=\"GitHub: #{tag.raw}\">#{tag.raw}</a>, "
      when "~" # Facebook
        "<a href=\"http://facebook.com/search.php?q=#{tag.param}\" class=\"facebook\" title=\"Facebook: #{tag.param}\">#{tag.raw}</a>, "
      when "?" # Wikipedia
        "<a href=\"http://en.wikipedia.org/w/index.php?title=Special%3ASearch&search=#{tag.raw}\" class=\"wikipedia\" title=\"Wikipedia: #{tag.param}\">#{tag.raw}</a>, "
      else
        "<a href=\"http://www.google.com/search?ie=UTF-8&q=#{tag.param}\" class=\"google\" title=\"Google: #{tag.raw}\">#{tag.raw}</a>, "

# Runtime
jQuery -> _.each $('article .tags'), (forPost) -> new TagList(forPost)
