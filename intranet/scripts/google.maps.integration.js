function MapInitializer(map, centroid) {
  var properties = {
    center: centroid,
    zoom: 19,
    mapTypeId: google.maps.MapTypeId.HYBRID
  };
  var map = new google.maps.Map(map, properties);

  return map;
}

 function setMarker(map,position,title) {
     var marker = new google.maps.Marker({
    //icon: '../Images/48.png',
    position: position,
    map: map,
    title: title
  });
  return marker;
 }

 function setInfoWindowValues(map, position, content) {
  return function () {
    infowindow = new google.maps.InfoWindow();
    infowindow.setContent(content);
    infowindow.setPosition(position);
    infowindow.open(map);
  };
}

function drawPolygon(polygon, map, color) {
  var flightPath = new google.maps.Polygon({
    path: polygon,
    strokeColor: color, //"#0000FF",
    strokeOpacity: 0.8,
    strokeWeight: 1,
    fillColor: color, //"#0000FF",
    fillOpacity: 0.4
  });
  flightPath.setMap(map);
}

function drawUbication(centroid, polygon, divName, message,markerTitle) {
  var mapCanvas = document.getElementById(divName);
  var map = MapInitializer(mapCanvas, centroid);
  drawPolygon(polygon,map,"#0000FF");

  var marker = setMarker(map,centroid, markerTitle);
  marker.setMap(map);
  var fn = setInfoWindowValues(map, marker.position, message);
  google.maps.event.addListener(marker, 'click', fn);
  google.maps.event.trigger(map, "resize");
  map.setCenter(centroid);
}

function ParseCoords(coords) {
  var aux = [];
  for (i = 0; i < coords.length; i++) {
    var point = new google.maps.LatLng(parseFloat(coords[i].Lat), parseFloat(coords[i].Lng));
    aux.push(point);
  }
  return aux;
}