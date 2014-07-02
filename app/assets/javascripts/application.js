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
//= require handlebars.runtime
//= require ./jquery.cycle.all
//= require_tree ./general
//= require_tree ./templates

;(function(win, doc) {

  var globalParams = $('#js-global').data('params')

  var MFM = window.MFM = {
      version: 0.1
    , maps: {}
    , markers: {}
  }

  $('#toggle-menu').click(function(e) {
    e.stopPropagation()
    e.preventDefault()
    $('#main-menu').slideToggle(200)
    $('#main-menu').toggleClass('active')
  })

  MFM.FoursquareApi = (function() {
    var f = {}
      , foursquareApiUrl = 'https://api.foursquare.com/v2'
      , accessToken = globalParams.foursquare.oauth_token

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

  MFM.apiRequest = function(endpoint, method, data) {
    endpoint = endpoint || '/'
    method = method || 'GET'
    data = data || {}
    return $.ajax({
        url: endpoint
      , type: method
      , data: data
      , dataType: 'json'
    })
  }

  MFM.setMap = function(selector, name, lat, lng, zoom, marker) {
    var center = new google.maps.LatLng(lat, lng)
      , options = { center: center, zoom: zoom }
      , map = new google.maps.Map(document.getElementById(selector), options)
    this.maps[name] = map
    if(marker) {
      MFM.addMarker('center', name, lat, lng)
    }
  }

  MFM.addMarker = function(name, mapName, lat, lng, opt) {
    var mapMarkers
      , options
    opt = opt || {}
    mapMarkers = MFM.markers[mapName] = MFM.markers[mapName] || {}
    options = {
        position: new google.maps.LatLng(lat, lng)
      , map: this.maps[mapName]
    }
    options = $.extend(options, opt)
    mapMarkers[name] = new google.maps.Marker(options)
  }

  MFM.getMarkers = function(mapName) {
    return MFM.markers[mapName]
  }

  MFM.removeMarker = function(mapName, markerName) {
    MFM.markers[mapName][markerName].setMap(null)
    delete MFM.markers[mapName][markerName]
  }

  MFM.removeAllMarkers = function(mapName, evenCenter) {
    for(marker in MFM.markers[mapName]) {
      if(!evenCenter && marker === 'center') {
        continue
      }
      MFM.removeMarker(mapName, marker)
    }
  }

  MFM.customMarker = function(pinColor) {
    return pinImage = new google.maps.MarkerImage('http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|' + pinColor,
      new google.maps.Size(21, 34),
      new google.maps.Point(0,0),
      new google.maps.Point(10, 34))
  }

})(window, window.document)
