# Highlight the clicked article if it exists
highlightClickedArticle = (path) ->
  path_arr = path.split '/'
  if path_arr.length >= 4
    title = path_arr[4].split('-').join(' ')
    $('#articles li').each (i, a) ->
      article_title = $(a).text().split('_').join(' ')
      if !!article_title.match(title)
        $('#articles li').css(backgroundColor: 'inherit')
        $(a).css(backgroundColor: '#eee')

jQuery ->
  highlightClickedArticle(window.location.pathname)

  $('#articles a').live 'click', (event) ->
    event.preventDefault()
    url = $(this).attr 'href'

    $.get url, (article) ->
      $('#canvas').html(article)
      history.pushState { id: url }, "", url if Modernizr.history
      highlightClickedArticle(url)
