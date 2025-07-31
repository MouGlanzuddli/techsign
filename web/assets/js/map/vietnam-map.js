(function($) {
    "use strict";

    function mainMap() {
        // Tọa độ trung tâm Việt Nam (Hà Nội)
        var vietnamCenter = { lat: 21.0285, lng: 105.8542 };
        
        // Giới hạn bản đồ cho Việt Nam
        var vietnamBounds = {
            north: 23.3934, // Biên giới phía Bắc
            south: 8.5596,  // Biên giới phía Nam
            east: 109.4693, // Biên giới phía Đông
            west: 102.1484  // Biên giới phía Tây
        };

        // Tạo bản đồ với giới hạn Việt Nam
        var map = new google.maps.Map(document.getElementById('map-main'), {
            zoom: 6,
            scrollwheel: false,
            center: vietnamCenter,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            zoomControl: true,
            mapTypeControl: false,
            scaleControl: true,
            panControl: false,
            fullscreenControl: true,
            navigationControl: false,
            streetViewControl: false,
            animation: google.maps.Animation.BOUNCE,
            gestureHandling: 'cooperative',
            // Giới hạn bản đồ chỉ trong phạm vi Việt Nam
            restriction: {
                latLngBounds: vietnamBounds,
                strictBounds: false
            },
            styles: [{
                "featureType": "administrative",
                "elementType": "labels.text.fill",
                "stylers": [{
                    "color": "#444444"
                }]
            }]
        });

        // Sử dụng dữ liệu từ helper nếu có
        var vietnamCities = [];
        if (window.VietnamMapHelper && window.VietnamMapHelper.citiesData) {
            Object.keys(window.VietnamMapHelper.citiesData).forEach(function(cityKey) {
                var cityData = window.VietnamMapHelper.citiesData[cityKey];
                vietnamCities.push({
                    name: cityData.name,
                    position: { lat: cityData.lat, lng: cityData.lng },
                    description: "Thành phố Việt Nam"
                });
            });
        } else {
            // Fallback data nếu helper chưa load
            vietnamCities = [
                {
                    name: "Hà Nội",
                    position: { lat: 21.0285, lng: 105.8542 },
                    description: "Thủ đô Việt Nam"
                },
                {
                    name: "TP. Hồ Chí Minh",
                    position: { lat: 10.8231, lng: 106.6297 },
                    description: "Thành phố lớn nhất Việt Nam"
                },
                {
                    name: "Đà Nẵng",
                    position: { lat: 16.0544, lng: 108.2022 },
                    description: "Thành phố biển miền Trung"
                },
                {
                    name: "Hải Phòng",
                    position: { lat: 20.8449, lng: 106.6881 },
                    description: "Thành phố cảng"
                },
                {
                    name: "Cần Thơ",
                    position: { lat: 10.0452, lng: 105.7469 },
                    description: "Thành phố Tây Đô"
                }
            ];
        }

        var markers = [];
        var infoWindows = [];

        // Tạo markers cho các thành phố
        vietnamCities.forEach(function(city, index) {
            var marker = new google.maps.Marker({
                position: city.position,
                map: map,
                title: city.name,
                animation: google.maps.Animation.DROP,
                icon: {
                    url: 'data:image/svg+xml;charset=UTF-8,' + encodeURIComponent(`
                        <svg width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="12" cy="12" r="10" fill="#016551" stroke="#FFFFFF" stroke-width="2"/>
                            <circle cx="12" cy="12" r="4" fill="#FFFFFF"/>
                        </svg>
                    `),
                    scaledSize: new google.maps.Size(24, 24)
                }
            });

            var infoWindow = new google.maps.InfoWindow({
                content: '<div style="padding: 10px;"><h4>' + city.name + '</h4><p>' + city.description + '</p></div>'
            });

            markers.push(marker);
            infoWindows.push(infoWindow);

            // Thêm sự kiện click cho marker
            marker.addListener('click', function() {
                // Đóng tất cả info windows khác
                infoWindows.forEach(function(infoWindow) {
                    infoWindow.close();
                });
                
                // Mở info window cho marker được click
                infoWindow.open(map, marker);
                
                // Cập nhật form fields
                if (window.VietnamMapHelper) {
                    window.VietnamMapHelper.updateFormFields(city.name, city.position.lat, city.position.lng);
                } else {
                    updateFormFields(city.name, city.position.lat, city.position.lng);
                }
            });
        });

        // Hàm cập nhật các trường form (fallback)
        function updateFormFields(cityName, lat, lng) {
            // Cập nhật trường địa chỉ
            var addressField = document.querySelector('input[name="permanentAddress"]');
            if (addressField) {
                addressField.value = cityName + ', Việt Nam';
            }

            // Cập nhật trường latitude
            var latField = document.querySelector('input[name="latitude"]');
            if (latField) {
                latField.value = lat;
            }

            // Cập nhật trường longitude
            var lngField = document.querySelector('input[name="longitude"]');
            if (lngField) {
                lngField.value = lng;
            }

            // Cập nhật trường state/city
            var stateCityField = document.querySelector('select[name="stateCity"]');
            if (stateCityField) {
                // Tìm option phù hợp hoặc tạo mới
                var found = false;
                for (var i = 0; i < stateCityField.options.length; i++) {
                    if (stateCityField.options[i].text.toLowerCase().includes(cityName.toLowerCase())) {
                        stateCityField.selectedIndex = i;
                        found = true;
                        break;
                    }
                }
                
                // Nếu không tìm thấy, thêm option mới
                if (!found) {
                    var option = document.createElement('option');
                    option.value = cityName;
                    option.text = cityName;
                    stateCityField.appendChild(option);
                    stateCityField.value = cityName;
                }
            }
        }

        // Thêm sự kiện click trên bản đồ để chọn vị trí
        map.addListener('click', function(event) {
            var lat = event.latLng.lat();
            var lng = event.latLng.lng();
            
            // Kiểm tra xem có trong phạm vi Việt Nam không
            if (window.VietnamMapHelper && window.VietnamMapHelper.isInVietnam) {
                if (window.VietnamMapHelper.isInVietnam(lat, lng)) {
                    handleMapClick(event.latLng);
                }
            } else {
                // Fallback validation
                if (lat >= vietnamBounds.south && lat <= vietnamBounds.north &&
                    lng >= vietnamBounds.west && lng <= vietnamBounds.east) {
                    handleMapClick(event.latLng);
                }
            }
        });

        function handleMapClick(latLng) {
            // Tạo marker tạm thời
            var tempMarker = new google.maps.Marker({
                position: latLng,
                map: map,
                animation: google.maps.Animation.BOUNCE,
                icon: {
                    url: 'data:image/svg+xml;charset=UTF-8,' + encodeURIComponent(`
                        <svg width="32" height="32" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="16" cy="16" r="12" fill="#FF4444" stroke="#FFFFFF" stroke-width="2"/>
                            <circle cx="16" cy="16" r="6" fill="#FFFFFF"/>
                        </svg>
                    `),
                    scaledSize: new google.maps.Size(32, 32)
                }
            });

            // Xóa marker tạm thời sau 2 giây
            setTimeout(function() {
                tempMarker.setMap(null);
            }, 2000);

            // Cập nhật form fields
            if (window.VietnamMapHelper) {
                window.VietnamMapHelper.updateFormFields('Vị trí được chọn', latLng.lat(), latLng.lng());
            } else {
                updateFormFields('Vị trí được chọn', latLng.lat(), latLng.lng());
            }
        }

        // Thêm controls cho bản đồ
        var zoomControlDiv = document.createElement('div');
        var zoomControl = new ZoomControl(zoomControlDiv, map);

        function ZoomControl(controlDiv, map) {
            zoomControlDiv.index = 1;
            map.controls[google.maps.ControlPosition.RIGHT_CENTER].push(zoomControlDiv);
            controlDiv.style.padding = '5px';
            var controlWrapper = document.createElement('div');
            controlDiv.appendChild(controlWrapper);
            var zoomInButton = document.createElement('div');
            zoomInButton.className = "mapzoom-in";
            controlWrapper.appendChild(zoomInButton);
            var zoomOutButton = document.createElement('div');
            zoomOutButton.className = "mapzoom-out";
            controlWrapper.appendChild(zoomOutButton);
            google.maps.event.addDomListener(zoomInButton, 'click', function () {
                map.setZoom(map.getZoom() + 1);
            });
            google.maps.event.addDomListener(zoomOutButton, 'click', function () {
                map.setZoom(map.getZoom() - 1);
            });
        }

        // Xử lý resize window
        google.maps.event.addDomListener(window, "resize", function () {
            var center = map.getCenter();
            google.maps.event.trigger(map, "resize");
            map.setCenter(center);
        });

        // Set map instance cho helper
        if (window.VietnamMapHelper && window.VietnamMapHelper.setMapInstance) {
            window.VietnamMapHelper.setMapInstance(map, markers);
        }
    }

    // Khởi tạo bản đồ khi trang load
    var map = document.getElementById('map-main');
    if (typeof (map) != 'undefined' && map != null) {
        google.maps.event.addDomListener(window, 'load', mainMap);
    }

})(this.jQuery); 