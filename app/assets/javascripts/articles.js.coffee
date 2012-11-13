jQuery ->
  $('#articles a').live 'click', (event) ->
    event.preventDefault()
    url = $(this).attr 'href'

    $.get url, (article) ->
      $('#canvas').html(article)
      history.pushState { id: url }, "", url if Modernizr.history
