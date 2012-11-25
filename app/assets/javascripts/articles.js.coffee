# Highlight the clicked article if it exists
highlight_article_from = (path) ->
  path_arr = path.split '/'
  if path_arr.length >= 4
    title = path_arr[4].split('-').join(' ')
    $('#articles li').each (i, a) ->
      article_title = $(a).text().replace(/_|,/, ' ').split('  ').join(' ')
      if !!article_title.match(title)
        $('#articles li').css(backgroundColor: 'inherit')
        $(a).css(backgroundColor: '#eee')

jQuery ->
  highlight_article_from window.location.pathname

  $(document).pjax('a', container: '#canvas')
    .on 'pjax:send', ->
      _gaq.push(['_trackPageview', window.location.pathname]);
      $(this).html("<img src=\"/assets/spinner.gif\" alt=\"Loading...\" />")
    .on 'pjax:error', (e,xhr,err) ->
      $(this).prepend $("<div class=\"alert alert-error\">#{err}</div>")
    .on  'pjax:end', ->
      highlight_article_from window.location.pathname
