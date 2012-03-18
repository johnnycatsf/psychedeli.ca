// This is just a test
$(function() {
  $.fn.ticker = function(options) {
    var config = {
      url: "/status"
    };

    $.fn.extend(config, options);

    $.ajax({
      url: config.url,
      type: 'GET',
      dataType: 'json',
      success: function(response) {
        if (response.statuses.length) {
          _.each(statuses, function(status) {
            console.log(status.message+" <"+status.link+"> ["+status.date+"]");
          });
        }
      }
    });
  };
});
