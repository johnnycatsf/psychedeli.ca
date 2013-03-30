sumatra 'highlightArticle', ->
  class HighlightArticle extends SumatraPlugin
    action: null

    initialize: ->
      path = window.options.pathname
      path_arr = path.split '/'

      if path_arr.length >= 4
        @currentTitle = path_arr[4].split('-').join(' ')
        @element.each @_highlightArticleIfCurrent

    _highlightArticleIfCurrent: (i, article) =>
      article_title = $(article).text() \
                                .replace(/_|,/, ' ')
                                .split('  ').join(' ')
      if !!article_title.match(@currentTitle)
        @element.css(backgroundColor: 'inherit')
        $(article).css(backgroundColor: '#eee')
