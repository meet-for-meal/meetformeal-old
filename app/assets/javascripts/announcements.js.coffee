MFM = window.MFM || {}


$(document).ready ->

  body = $('body')
  if  body.hasClass('announcements-new') or
      body.hasClass('announcements-show') or
      body.hasClass('announcements-create')

    form = $('form')
    latitudeInput = form.find('#announcement_lat')
    longitudeInput = form.find('#announcement_lng')

    onChangeGeoloc = ->
      MFM.removeMarker('addAnnouncement', 'center')
      MFM.addMarker('center', 'addAnnouncement', latitudeInput.val(), longitudeInput.val())

    latitudeInput.change onChangeGeoloc
    longitudeInput.change onChangeGeoloc
    $('.js-changeGeoloc').click onChangeGeoloc

    location = $('#js-user-location').data('location')
    location = [48.8548, 2.3466] unless location instanceof Array
    MFM.setMap('map-canvas', 'addAnnouncement', location[0], location[1], 12, yes)
