$(document).ready(function() {

	console.log("Am I working?");

	if ($('.map-canvas').length <= 0 ) {
		return;
	};

	console.log($('.map-canvas').length);

	var mapCanvas = document.getElementsByClassName('map-canvas')[0];

	var mapOptions = {

		center: new google.maps.LatLng(gon.lat, gon.long),
		zoom: 17,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};

	var map = new google.maps.Map(mapCanvas, mapOptions);
	
	var marker = new google.maps.Marker({
		position: { lat: gon.lat, lng: gon.lng },
		map: map
	});

})