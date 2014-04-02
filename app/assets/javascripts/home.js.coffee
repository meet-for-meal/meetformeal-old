class User
  constructor: (@name, @lat, @lng) ->


MFM = window.MFM || {}
currentUser = MFM.currentUser = new User 'rhannequin', 1.289272, 103.863146
userPosition = "#{currentUser.lat},#{currentUser.lng}"


$(document).ready ->

  initMap = ->
    currentUser = MFM.currentUser
    myLatlng = lat: 1.289272, lng: 103.863146
    singaporeFlyer = new google.maps.LatLng currentUser.lat, currentUser.lng
    mapOptions = center: singaporeFlyer, zoom: 13
    MFM.map = new google.maps.Map document.getElementById('map-canvas'), mapOptions

  initMarkers = (users) ->
    map = MFM.map
    markers = map.markers = []
    currentUser = MFM.currentUser

    addMarker map, currentUser.lat, currentUser.lng

    venuesParams =
      categoryId: '4d4b7105d754a06374d81259'
      ll: "#{currentUser.lat},#{currentUser.lng}"
    MFM.FoursquareApi.req '/venues/search', venuesParams, (data) ->
      data.response.venues.forEach (venue) ->
        location = venue.location
        markerOpt =
          icon: customMarker('335BB7')
          title: venue.name
        addMarker map, location.lat, location.lng, markerOpt

  addMarker = (map, lat, lng, opt = {}) ->
    options = position: new google.maps.LatLng(lat, lng) , map: map
    options = $.extend options, opt
    new google.maps.Marker options

  customMarker = (pinColor) ->
    pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|#{pinColor}",
        new google.maps.Size(21, 34),
        new google.maps.Point(0,0),
        new google.maps.Point(10, 34))

  initMap()
  initMarkers()
