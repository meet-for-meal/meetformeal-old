class User
  constructor: (@name, @lat, @lng) ->


MFM = window.MFM || {}
currentUser = MFM.currentUser = new User 'rhannequin', 48.8567, 2.3508


$(document).ready ->

  mapName = 'mainMap'

  initMap = ->
    currentUser = MFM.currentUser
    MFM.setMap 'googlemaps', mapName, currentUser.lat, currentUser.lng, 13, yes

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

  getNearAnnouncements = ->
    req = MFM.apiRequest "/announcements/near?lat=#{currentUser.lat}&lng=#{currentUser.lng}"
    req.done (announcements) ->
      for announcement in announcements
        title = announcement.title
        markerOpt =
          icon: MFM.customMarker('55B53D')
          title: title
        MFM.addMarker title, mapName, announcement.lat, announcement.lng, markerOpt


  initMap()
  initMarkers()
  getNearAnnouncements()
  initSlider()
