sumatra 'pageTitle', ->
  class PageTitle extends SumatraHelper
    action: null
    defaults:
      fromSelector: 'h1'
      defaultTitle: "psychedeli.ca | tubbo's random musings"
      homePageTitle: "hi, i'm tom"
      suffix: "psychedeli.ca"

    initialize: ->
      @currentPageTitleElement = $(@options.fromSelector).first()
      throw "Selector not found" unless @currentPageTitleElement?
      @currentPageTitle = @currentPageTitleElement.text()
      @element.text @_fullTitle()

    _fullTitle: ->
      if @options.homePageTitle is @currentPageTitle
        @options.defaultTitle
      else
        "#{@currentPageTitle} | #{@options.suffix}"
