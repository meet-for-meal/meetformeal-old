MFM = window.MFM || {}

$(document).ready ->

  # Announcements#show actions
  if $('body').hasClass('announcements-show')
    location = $('#js-user-location').data('location')
    lat = location[0]
    lng = location[1]
    latLng = new google.maps.LatLng(lat, lng)
    MFM.setMap('map-canvas', 'showAnnoucement', lat, lng, 12, yes)
    new google.maps.Geocoder().geocode { 'location': latLng }, (results, status) ->
      address = results[0].address_components
      $('.js-announcement-location').html(address[1].long_name + ', ' + address[2].long_name)
