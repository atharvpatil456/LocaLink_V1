<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Select Location</title>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDHS0pNTI7fnejHG5-lmHo5JmqSZU8gTUQ&libraries=places" async defer></script>
    <style>
        /* General styling for the page */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f0f2f5;
        }
        h2 {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
        }
        /* Search input styling */
        #search-input {
            width: 300px;
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 15px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
        }
        /* Map container styling */
        #map {
            height: 400px;
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin-bottom: 15px;
        }
        /* Input fields for coordinates and address */
        .info-field {
            display: flex;
            flex-direction: column;
            margin-bottom: 10px;
        }
        .info-field label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }
        .info-field input {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #fff;
        }
        /* Save button styling */
        button {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        let map, selectedMarker, geocoder;

        function initMap() {
            const defaultLocation = { lat: -34.397, lng: 150.644 }; // Default location (Sydney)

            // Initialize the map and geocoder
            map = new google.maps.Map(document.getElementById("map"), {
                zoom: 10,
                center: defaultLocation
            });
            geocoder = new google.maps.Geocoder();

            // Attempt to get user's current location
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition((position) => {
                    const userLocation = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };
                    map.setCenter(userLocation);
                }, () => {
                    alert("Unable to retrieve location. Default location is set.");
                });
            } else {
                alert("Geolocation not supported by this browser. Default location is set.");
            }

            // Map click listener to set marker and fetch address
            map.addListener("click", (event) => {
                placeMarker(event.latLng);
            });

            // Search bar functionality
            const input = document.getElementById("search-input");
            const searchBox = new google.maps.places.SearchBox(input);
            map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

            searchBox.addListener("places_changed", () => {
                const places = searchBox.getPlaces();
                if (places.length === 0) return;

                if (selectedMarker) {
                    selectedMarker.setMap(null);
                }

                const place = places[0];
                if (!place.geometry) return;

                map.setCenter(place.geometry.location);
                placeMarker(place.geometry.location);
            });
        }

        // Function to place marker and fetch address
        function placeMarker(location) {
            if (selectedMarker) {
                selectedMarker.setMap(null);
            }

            selectedMarker = new google.maps.Marker({
                position: location,
                map: map
            });

            const lat = location.lat();
            const lng = location.lng();
            document.getElementById("latitude").value = lat;
            document.getElementById("longitude").value = lng;

            // Get the address based on latitude and longitude
            geocodeLatLng(lat, lng);
        }

        // Function to get address from latitude and longitude
        function geocodeLatLng(lat, lng) {
            const latlng = { lat: parseFloat(lat), lng: parseFloat(lng) };
            geocoder.geocode({ location: latlng }, (results, status) => {
                if (status === "OK") {
                    if (results[0]) {
                        document.getElementById("address").value = results[0].formatted_address;
                    } else {
                        document.getElementById("address").value = "No address found";
                    }
                } else {
                    document.getElementById("address").value = "Geocoder failed: " + status;
                }
            });
        }

        function saveLocation() {
            const latitude = document.getElementById("latitude").value;
            const longitude = document.getElementById("longitude").value;
            const address = document.getElementById("address").value;

            if (!latitude || !longitude) {
                alert("Please select a location on the map first.");
                return;
            }

            // Send the latitude, longitude, and address to the parent form
            window.opener.document.getElementById("latitude").value = latitude;
            window.opener.document.getElementById("longitude").value = longitude;
            window.opener.document.getElementById("address").value = address;

            window.close(); // Close map window
        }
    </script>
</head>
<body onload="initMap()">
    <h2>Select Location on Map</h2>

    <input id="search-input" class="controls" type="text" placeholder="Search for a city or place"/><br/>

    <div id="map"></div>

    <div class="info-field">
        <label>Latitude:</label>
        <input type="text" id="latitude" readonly/>
    </div>

    <div class="info-field">
        <label>Longitude:</label>
        <input type="text" id="longitude" readonly/>
    </div>

    <div class="info-field">
        <label>Address:</label>
        <input type="text" id="address" readonly/>
    </div>

    <button onclick="saveLocation()">Save Selected Location</button>
</body>
</html>
