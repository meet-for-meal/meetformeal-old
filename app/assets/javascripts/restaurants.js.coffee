Handlebars.registerHelper 'displayCategories', (categories) ->
  arr = []
  arr.push category.name for category in categories
  arr.join(' / ')

Handlebars.registerHelper 'categoryLogo', (categories) ->
  icon = categories[0].icon
  "#{icon.prefix}bg_32#{icon.suffix}"


class User
  constructor: (@lat, @lng) ->


MFM = window.MFM || {}


$(document).ready ->

  currentUser = null
  mapName = 'mainMap'
  template = HandlebarsTemplates['restaurants/item_list']
  geolocOptions =
    enableHighAccuracy: yes
    timeout: 10 * 1000 * 1000
    maximumAge: 0
  fakeLat = 48.8567
  fakeLng = 2.3508

  $('.find-venues').on 'click', (e) ->
    MFM.removeAllMarkers mapName, no
    if currentUser?
      initVenues currentUser.lat, currentUser.lng

  checkAll = (e) ->
    e.preventDefault()
    check = $(this).hasClass('check-all')
    $inputs = $('.categories').find('input:checkbox')
    $inputs.prop 'checked', check

  $('.check-all').on 'click', checkAll
  $('.uncheck-all').on 'click', checkAll


  initPosition = ->
    geo = navigator.geolocation
    if geo?
      geo.getCurrentPosition successPosition, errorPosition, geolocOptions
    else
      initMap fakeLat, fakeLng
      initVenues fakeLat, fakeLng

  successPosition = (position) ->
    coords = position.coords
    lat = coords.latitude
    lng = coords.longitude
    initMap lat, lng
    # initMap fakeLat, fakeLng
    initVenues lat, lng

  errorPosition = (err) ->
    cl = 'hidden'
    $('.js-manual-location').find(".#{cl}").removeClass(cl)

  initMap = (lat, lng) ->
    currentUser = new User lat, lng
    MFM.setMap 'googlemaps', mapName, lat, lng, 13, yes

  initVenues = (lat, lng) ->
    categories = getSelectedCategories()
    searchFoursquareVenues lat, lng, categories

  getSelectedCategories = ->
    categories = []
    $('.categories').find('input:checked').each (i, el) ->
      categories.push $(el).attr('name')
    categories

  searchFoursquareVenues = (lat, lng, categories) ->
    venuesParams =
      categoryId: categories.join(',')
      ll: "#{lat},#{lng}"
      intent: 'browse'
      radius: 5000
    MFM.FoursquareApi.req '/venues/search', venuesParams, displayVenues

  displayVenues = (data) ->
    $ul = $('#search-result')
    html = ''
    customMarker = MFM.customMarker '335BB7'
    data.response.venues.forEach (venue) ->
      html += template(venue)
      location = venue.location
      markerOpt =
        icon: customMarker
        title: venue.name
      MFM.addMarker venue.id, mapName, location.lat, location.lng, markerOpt
    $ul.html html

  initManualPosition = ->
    $('.js-manual-location').find('form').on 'submit', (e) ->
      e.preventDefault()
      address = $(this).find('input').val()
      new google.maps.Geocoder().geocode { address: address }, (results, status) ->
        if results.length > 0
          place = results[0]
          location = place.geometry.location
          lat = location.k
          lng = location.A
          initMap lat, lng
          initVenues lat, lng


  initPosition()
  initManualPosition()
