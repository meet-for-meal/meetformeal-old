Handlebars.registerHelper 'displayCategories', (categories) ->
  arr = []
  arr.push category.name for category in categories
  arr.join(' / ')

Handlebars.registerHelper 'categoryLogo', (categories) ->
  icon = categories[0].icon
  "#{icon.prefix}bg_32#{icon.suffix}"


MFM = window.MFM || {}


$(document).ready ->

  mapName = 'mainMap'
  template = HandlebarsTemplates['restaurants/item_list']


  initPosition = ->
    if navigator.geolocation?
      navigator.geolocation.getCurrentPosition (position) ->
        coords = position.coords
        initMap coords.latitude, coords.longitude # 48.8567, 2.3508

  initMap = (lat, lng) ->
    categories = getSelectedCategories()
    MFM.setMap 'googlemaps', mapName, lat, lng, 13, yes
    venuesParams =
      categoryId: categories.join(',')
      ll: "#{lat},#{lng}"
      intent: 'browse'
      radius: 5000
    MFM.FoursquareApi.req '/venues/search', venuesParams, (data) ->
      $ul = $('#search-result')
      html = ''
      data.response.venues.forEach (venue) ->
        html += template(venue)
        location = venue.location
        markerOpt =
          icon: MFM.customMarker('335BB7')
          title: venue.name
        MFM.addMarker venue.id, mapName, location.lat, location.lng, markerOpt
      $ul.append html

  getSelectedCategories = ->
    categories = []
    $('.categories').find('input').each (i, el) ->
      categories.push $(el).attr('name')
    categories


  initPosition()
