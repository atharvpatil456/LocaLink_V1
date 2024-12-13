<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Select Location</title>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDHS0pNTI7fnejHG5-lmHo5JmqSZU8gTUQ&libraries=places"
            async defer></script>
    <style>
        #map {
            height: 400px;
            width: 100%;
            margin-top: 10px;
        }

        .controls {
            margin: 10px 0;
            padding: 8px;
            font-size: 14px;
            border-radius: 4px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
        }

        button {
            margin-top: 10px;
            padding: 8px 12px;
            font-size: 16px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        var map, selectedMarker;

        function initMap() {
            const defaultLocation = {lat: -34.397, lng: 150.644};  // Default to Sydney

            map = new google.maps.Map(document.getElementById('map'), {
                zoom: 10,
                center: defaultLocation
            });

            // Attempt to get the user's current location
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    position => {
                        const userLocation = {
                            lat: position.coords.latitude,
                            lng: position.coords.longitude
                        };
                        map.setCenter(userLocation);
                        placeMarker(userLocation);
                    },
                    () => {
                        alert("Could not retrieve location. Using default location.");
                        map.setCenter(defaultLocation);
                    }
                );
            } else {
                alert("Geolocation is not supported by this browser. Using default location.");
                map.setCenter(defaultLocation);
            }

            // Listener for map click to place a marker
            map.addListener('click', event => placeMarker(event.latLng));

            // Search bar functionality
            const input = document.getElementById('search-input');
            const searchBox = new google.maps.places.SearchBox(input);
            map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

            searchBox.addListener('places_changed', () => {
                const places = searchBox.getPlaces();
                if (places.length === 0) return;

                const place = places[0];
                if (!place.geometry) return;

                map.setCenter(place.geometry.location);
                placeMarker(place.geometry.location);
            });
        }

        // Function to place a marker and update latitude/longitude fields
        function placeMarker(location) {
            if (selectedMarker) selectedMarker.setMap(null);
            selectedMarker = new google.maps.Marker({
                position: location,
                map: map
            });
            document.getElementById('latitude').value = location.lat();
            document.getElementById('longitude').value = location.lng();
        }

        // Function to save selected location to the parent page
        function saveLocation() {
            const latitude = document.getElementById('latitude').value;
            const longitude = document.getElementById('longitude').value;

            window.opener.document.getElementById('latitude').value = latitude;
            window.opener.document.getElementById('longitude').value = longitude;

            // Optionally close window
            window.close();
        }
    </script>
</head>
<body onload="initMap()">
    <h2>Select Location on Map</h2>
    <input id="search-input" class="controls" type="text" placeholder="Search for a location"/>

    <div id="map"></div>

    <label>Latitude:</label>
    <input type="text" id="latitude" readonly/><br/>

    <label>Longitude:</label>
    <input type="text" id="longitude" readonly/><br/>

    <button onclick="saveLocation()">Save Selected Location</button>
</body>
</html>
