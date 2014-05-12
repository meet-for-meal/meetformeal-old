MFM = window.MFM || {}


$(document).ready ->

  body = $('body')
  if(body.hasClass('announcements-new') || body.hasClass('announcements-show')) 

    location = $('#js-user-location').data('location')
    map = MFM.createMap('map-canvas', 'addAnnouncement', location[0], location[1], 12, yes)
