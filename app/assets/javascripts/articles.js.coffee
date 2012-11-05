jQuery ->
  $('#articles a').live 'click', (event) ->
    event.preventDefault()
    url = $(this).attr 'href'

    $.get url, (article) -> $('#canvas').html(article)
