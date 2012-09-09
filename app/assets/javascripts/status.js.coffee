jQuery.fn.ticker = -> 
  $.getJSON "/status.json", (response) ->
    _.each response.statuses, (status) ->
      console.log status.message
