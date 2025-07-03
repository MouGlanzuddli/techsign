(function($) {
    "use strict";

    // Tọa độ các thành phố Việt Nam
    var vietnamCitiesData = {
        "Ha Noi": { lat: 21.0285, lng: 105.8542, name: "Hà Nội" },
        "Ho Chi Minh": { lat: 10.8231, lng: 106.6297, name: "TP. Hồ Chí Minh" },
        "Da Nang": { lat: 16.0544, lng: 108.2022, name: "Đà Nẵng" },
        "Hai Phong": { lat: 20.8449, lng: 106.6881, name: "Hải Phòng" },
        "Can Tho": { lat: 10.0452, lng: 105.7469, name: "Cần Thơ" },
        "Hue": { lat: 16.4637, lng: 107.5909, name: "Huế" },
        "Nha Trang": { lat: 12.2388, lng: 109.1967, name: "Nha Trang" },
        "Vung Tau": { lat: 10.3454, lng: 107.0843, name: "Vũng Tàu" },
        "Bien Hoa": { lat: 10.9574, lng: 106.8426, name: "Biên Hòa" },
        "Buon Ma Thuot": { lat: 12.6662, lng: 108.0382, name: "Buôn Ma Thuột" }
    };

    // Biến global để lưu trữ map instance
    var globalMap = null;
    var globalMarkers = [];

    // Hàm khởi tạo helper
    function initVietnamMapHelper() {
        // Lắng nghe sự kiện thay đổi của dropdown thành phố
        var stateCitySelect = document.querySelector('select[name="stateCity"]');
        if (stateCitySelect) {
            stateCitySelect.addEventListener('change', function() {
                var selectedCity = this.value;
                if (vietnamCitiesData[selectedCity]) {
                    var cityData = vietnamCitiesData[selectedCity];
                    updateMapToCity(cityData);
                    updateFormFields(cityData.name, cityData.lat, cityData.lng);
                }
            });
        }

        // Lắng nghe sự kiện thay đổi của trường địa chỉ
        var addressField = document.querySelector('input[name="permanentAddress"]');
        if (addressField) {
            addressField.addEventListener('blur', function() {
                // Có thể thêm logic geocoding ở đây nếu cần
                console.log('Address field changed:', this.value);
            });
        }
    }

    // Hàm cập nhật bản đồ đến thành phố được chọn
    function updateMapToCity(cityData) {
        if (globalMap) {
            var position = new google.maps.LatLng(cityData.lat, cityData.lng);
            globalMap.setCenter(position);
            globalMap.setZoom(12);

            // Tạo marker tạm thời để highlight thành phố được chọn
            var tempMarker = new google.maps.Marker({
                position: position,
                map: globalMap,
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

            // Xóa marker tạm thời sau 3 giây
            setTimeout(function() {
                tempMarker.setMap(null);
            }, 3000);
        }
    }

    // Hàm cập nhật các trường form
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
    }

    // Hàm set map instance (được gọi từ vietnam-map.js)
    function setMapInstance(map, markers) {
        globalMap = map;
        globalMarkers = markers;
    }

    // Hàm lấy dữ liệu thành phố
    function getCityData(cityKey) {
        return vietnamCitiesData[cityKey] || null;
    }

    // Hàm validate tọa độ có trong Việt Nam không
    function isInVietnam(lat, lng) {
        var vietnamBounds = {
            north: 23.3934,
            south: 8.5596,
            east: 109.4693,
            west: 102.1484
        };

        return lat >= vietnamBounds.south && lat <= vietnamBounds.north &&
               lng >= vietnamBounds.west && lng <= vietnamBounds.east;
    }

    // Export các hàm để sử dụng từ file khác
    window.VietnamMapHelper = {
        init: initVietnamMapHelper,
        setMapInstance: setMapInstance,
        getCityData: getCityData,
        isInVietnam: isInVietnam,
        updateMapToCity: updateMapToCity,
        updateFormFields: updateFormFields,
        citiesData: vietnamCitiesData
    };

    // Khởi tạo khi DOM ready
    $(document).ready(function() {
        initVietnamMapHelper();
    });

})(this.jQuery); 