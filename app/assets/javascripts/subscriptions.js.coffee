MFM = window.MFM || {}

$(document).ready ->

  # Subscriptions#index actions
  if $('body').hasClass('subscriptions-index')
    $('.js-announcement-location').each (i, el) ->
      $el = $(el)
      location = $el.data('location')
      lat = location[0]
      lng = location[1]
      latLng = new google.maps.LatLng(lat, lng)
      new google.maps.Geocoder().geocode { 'location': latLng }, (results, status) ->
        if results?
          address = results[0].address_components
          text = address[1].long_name + ', ' + address[2].long_name
        else
          text = "Impossible de déterminer l'emplacement"
        $el.html(text)
