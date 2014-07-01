Handlebars.registerHelper 'customDate', (dateStr) ->
  date = new Date dateStr
  date = new Date(date.getTime() + date.getTimezoneOffset()*60000)
  hours = date.getHours()
  hours = "0#{hours}" if hours < 10
  "#{hours}H"

Handlebars.registerHelper 'joinHobbies', (hobbies) ->
  hobbies.forEach (hobby, i) -> hobbies[i] = "##{hobby}"
  hobbies.join(', ')

# Temporary

Handlebars.registerHelper 'fakePpUrl', (owner) ->
  return '/assets/users/remy.jpg' if owner.email == 'm@rhannequin.com'
  i = owner.email.split('-')[0]
  g = owner.gender.charAt(0)
  "/assets/users/#{i}-#{g}.jpg"

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
      userIds = []
      $.each announcements, (i, announcement) -> userIds.push(announcement.owner.id)
      MFM.apiRequest("/users?users=#{getInvolvedUsers(userIds).join(',')}").done (users) ->
        formattedUsers = {}
        $.each users, (i, user) -> formattedUsers[user.id] = user
        templateParams = []
        $.each announcements, (i, announcement) ->
          title = announcement.title
          markerOpt = icon: MFM.customMarker('55B53D'), title: title
          MFM.addMarker title, mapName, announcement.lat, announcement.lng, markerOpt
          templateParams.push announcement: announcement, owner: formattedUsers[announcement.owner.id]
        template = HandlebarsTemplates['users/near_list']
        $('.js-near_users').html template(announcements: templateParams)

  getInvolvedUsers = (userIds) ->
    uniqueIds = []
    $.each userIds, (i, id) ->
      uniqueIds.push(id) if $.inArray(id, uniqueIds) is -1


  initMap()
  initSlider()
