class User
  constructor: (@name, @lat, @lng) ->


MFM = window.MFM || {}
currentUser = MFM.currentUser = new User 'rhannequin', 1.289272, 103.863146


$(document).ready ->

  mapName = 'mainMap'

  initMap = ->
    currentUser = MFM.currentUser
    MFM.createMap 'map-canvas', mapName, currentUser.lat, currentUser.lng, 13, yes

  initMarkers = (users) ->
    currentUser = MFM.currentUser
    venuesParams =
      categoryId: '4d4b7105d754a06374d81259'
      ll: "#{currentUser.lat},#{currentUser.lng}"
    MFM.FoursquareApi.req '/venues/search', venuesParams, (data) ->
      data.response.venues.forEach (venue) ->
        location = venue.location
        markerOpt =
          icon: MFM.customMarker('335BB7')
          title: venue.name
        MFM.addMarker venue.id, mapName, location.lat, location.lng, markerOpt

  initMap()
  initMarkers()
