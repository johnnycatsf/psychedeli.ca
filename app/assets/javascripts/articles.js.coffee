jQuery ->
  $('.nav-bar .social.button').tooltip placement: 'bottom'
  $('.nav-bar .rss.button').tooltip placement: 'left'

  $('#articles li').highlightArticle() # use the current title at first
  $(document).foundation()
  $(document).pjax('a', container: '#canvas')
    .on 'pjax:send', ->
      _gaq.push(['_trackPageview', window.location.pathname]);
      $(this).html("<img src=\"/assets/spinner.gif\" alt=\"Loading...\" />")
    .on 'pjax:error', (e,xhr,err) ->
      $(this).prepend $("<div class=\"alert alert-error\">#{err}</div>")
    .on  'pjax:end', ->
      $('#articles li').highlightArticle() # to the article we're changing to
      $('title').pageTitle fromSelector: '#canvas h1'
