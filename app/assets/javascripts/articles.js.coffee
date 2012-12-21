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

set_title_to = (page_title) ->
  new_title = if page_title == "hi, i'm tom"
    "psychedeli.ca | tubbo's random musings"
  else
    "#{page_title} | psychedeli.ca"

  $('title').text new_title


# Global pjax settings
$(document).pjax()
  .on 'pjax:send', ->
    _gaq.push(['_trackPageview', window.location.pathname]);
    $(this).html("<img src=\"/assets/spinner.gif\" alt=\"Loading...\" />")
  .on 'pjax:error', (e,xhr,err) ->
    $(this).prepend $("<div class=\"alert alert-error\">#{err}</div>")
  .on  'pjax:end', ->
    highlight_article_from window.location.pathname
    set_title_to $('#canvas h1').first().text()

jQuery ->
  highlight_article_from window.location.pathname

  # A workaround for cached HTML pages. Browsing to /article/id/(index.html)
  # goes to Articles#show, but browsing to /article/id/partial(.html) will
  # just serve the partial.
  $('#articles a').click (event) ->
    $.pjax
      url: "#{$(this).href()}/partial",
      container: '#canvas'


