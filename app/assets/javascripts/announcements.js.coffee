MFM = window.MFM || {}


$(document).ready ->

  location = $('#js-user-location').data('location')
  map = MFM.createMap('map-canvas', 'addAnnouncement', location[0], location[1], 12, yes)
