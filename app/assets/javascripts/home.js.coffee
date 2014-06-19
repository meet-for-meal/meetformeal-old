class User
  constructor: (@name, @lat, @lng) ->


MFM = window.MFM || {}


$(document).ready ->

  mapName = 'mainMap'

  initMap = ->
    geo = navigator.geolocation
    if geo?
      geo.getCurrentPosition (position) ->
        coords = position.coords
        lat = coords.latitude
        lng = coords.longitude
        MFM.setMap 'googlemaps', mapName, lat, lng, 13, yes
        initMarkers lat, lng
        getNearAnnouncements lat, lng

  initMarkers = (lat, lng) ->
    venuesParams =
      categoryId: '4d4b7105d754a06374d81259'
      ll: "#{lat},#{lng}"
      intent: 'browse'
      radius: 5000
    MFM.FoursquareApi.req '/venues/search', venuesParams, (data) ->
      data.response.venues.forEach (venue) ->
        location = venue.location
        markerOpt =
          icon: MFM.customMarker('335BB7')
          title: venue.name
        MFM.addMarker venue.id, mapName, location.lat, location.lng, markerOpt

  initSlider = ->
    $('html').click ->
      # Hide the menus if visible
      $('#notifications').slideUp 200
    $('.toggle-notif').click (e) ->
      e.stopPropagation()
      $('#notifications').slideToggle 200
      $(this).children('.notif').remove()
    $('#featured-restaurants').after('<div id="nav">').cycle
      fx:     'fade'
      speed:   1000
      timeout: 3000
      pager:  '#nav'

  getNearAnnouncements = (lat, lng) ->
    req = MFM.apiRequest "/announcements/near?lat=#{lat}&lng=#{lng}"
    req.done (announcements) ->
      for announcement in announcements
        title = announcement.title
        markerOpt =
          icon: MFM.customMarker('55B53D')
          title: title
        MFM.addMarker title, mapName, announcement.lat, announcement.lng, markerOpt


  initMap()
  initSlider()
