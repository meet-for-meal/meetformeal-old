// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap

;(function(win, doc) {

  var pageParams = $('#js-home').data('params')

  var MFM = window.MFM = {
    version: 0.1
  }

  MFM.FoursquareApi = (function() {
    var f = {}
      , foursquareApiUrl = 'https://api.foursquare.com/v2'
      , accessToken = pageParams.foursquare.oauth_token

    var defaultParams = { v: 20140401, oauth_token: accessToken }

    f.req = function (endpoint, params, success, error) {
      var urlParams = $.param($.extend(defaultParams, params))
        , req = $.ajax({ url: foursquareApiUrl + endpoint + '?' + urlParams })
      req.done(success)
      req.fail(error || function(){})
      return req
    }

    return f
  }).call(this)

})(window, window.document)
