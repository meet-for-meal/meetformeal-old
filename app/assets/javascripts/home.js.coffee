class User
  constructor: (@name, @lat, @lng) ->

pageParams = $('#js-home').data('params')

FoursquareApi = do ->
  f = {}
  foursquareApiUrl = 'https://api.foursquare.com/v2'
  accessToken = pageParams.foursquare.oauth_token
  defaultParams = v: 20140401, oauth_token: accessToken
  f.req = (endpoint, params, success, error) ->
    urlParams = $.param $.extend(defaultParams, params)
    req = $.ajax
      url: "#{foursquareApiUrl}#{endpoint}?#{urlParams}"
    req.done success
    req.fail(error || ->)
    req
  f


MFM = window.MFM = window.MFM || {}
currentUser = MFM.currentUser = new User 'rhannequin', 1.289272, 103.863146
userPosition = "#{currentUser.lat},#{currentUser.lng}"

FoursquareApi.req '/venues/search', { ll: "#{currentUser.lat},#{currentUser.lng}" }, (data) ->
  console.log data.response.venues


$(document).ready ->

  initMap = ->
    currentUser = MFM.currentUser
    myLatlng = lat: 1.289272, lng: 103.863146
    singaporeFlyer = new google.maps.LatLng currentUser.lat, currentUser.lng
    mapOptions = center: singaporeFlyer, zoom: 15
    MFM.map = new google.maps.Map document.getElementById('map-canvas'), mapOptions

  initMarkers = (users) ->
    map = MFM.map
    markers = map.markers = []
    currentUser = MFM.currentUser

    addMarker map, currentUser.lat, currentUser.lng
    addMarker map, 1.2855, 103.8630
    addMarker map, 1.281, 103.8620
    addMarker map, 1.2890, 103.84
    addMarker map, 1.29, 103.86

  addMarker = (map, lat, lng, title) ->
    options = position: new google.maps.LatLng(lat, lng) , map: map
    options.title = title if title?
    new google.maps.Marker options

  initMap()
  initMarkers()
