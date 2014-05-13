MFM = window.MFM || {}


$(document).ready ->

  body = $('body')
  if(body.hasClass('announcements-new') || body.hasClass('announcements-show'))

    form = $('form')
    latitudeInput = form.find('#announcement_latitude')
    longitudeInput = form.find('#announcement_longitude')

    onChangeGeoloc = ->
      MFM.removeMarker('addAnnouncement', 'center')
      MFM.addMarker('center', 'addAnnouncement', latitudeInput.val(), longitudeInput.val())

    latitudeInput.change onChangeGeoloc
    longitudeInput.change onChangeGeoloc
    $('.js-changeGeoloc').click onChangeGeoloc

    location = $('#js-user-location').data('location')
    map = MFM.createMap('map-canvas', 'addAnnouncement', location[0], location[1], 12, yes)
