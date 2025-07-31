# Hướng dẫn cài đặt Bản đồ Việt Nam cho JobSearchManagement

## Tổng quan
Hệ thống đã được cập nhật để sử dụng bản đồ Google Maps giới hạn trong phạm vi Việt Nam thay vì bản đồ toàn cầu như trước.

## Các thay đổi đã thực hiện

### 1. File JavaScript mới
- `web/assets/js/map/vietnam-map.js`: File chính xử lý bản đồ Việt Nam
- `web/assets/js/map/vietnam-map-helper.js`: Helper functions để đồng bộ form và bản đồ

### 2. File CSS mới
- `web/assets/css/vietnam-map.css`: Styles cho bản đồ Việt Nam

### 3. Cập nhật trang Post Job
- `web/company-submit-job.jsp`: Đã được cập nhật để sử dụng bản đồ Việt Nam

## Tính năng chính

### 1. Giới hạn địa lý
- Bản đồ chỉ hiển thị trong phạm vi Việt Nam
- Người dùng không thể pan/zoom ra ngoài biên giới Việt Nam
- Tọa độ được validate để đảm bảo nằm trong Việt Nam

### 2. Các thành phố chính
Bản đồ bao gồm các thành phố lớn của Việt Nam:
- Hà Nội (Thủ đô)
- TP. Hồ Chí Minh
- Đà Nẵng
- Hải Phòng
- Cần Thơ
- Huế
- Nha Trang
- Vũng Tàu
- Biên Hòa
- Buôn Ma Thuột

### 3. Tương tác
- Click vào marker để chọn thành phố
- Click vào bản đồ để chọn vị trí tùy ý
- Dropdown thành phố đồng bộ với bản đồ
- Tự động cập nhật tọa độ và địa chỉ

### 4. Giao diện
- Thiết kế responsive
- Animations cho markers
- Custom controls
- Info windows cho các thành phố

## Cài đặt

### 1. Google Maps API Key
Thay thế `YOUR_GOOGLE_MAPS_API_KEY` trong file `company-submit-job.jsp` bằng API key thực:

```html
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_ACTUAL_API_KEY&libraries=places"></script>
```

### 2. Cấu hình API Key
Để lấy Google Maps API Key:
1. Truy cập [Google Cloud Console](https://console.cloud.google.com/)
2. Tạo project mới hoặc chọn project hiện có
3. Enable Maps JavaScript API
4. Tạo credentials (API Key)
5. Giới hạn API Key cho domain của bạn

### 3. Kiểm tra hoạt động
1. Mở trang `company-submit-job.jsp`
2. Kiểm tra bản đồ hiển thị đúng Việt Nam
3. Test các tính năng:
   - Click vào các thành phố
   - Chọn từ dropdown
   - Click vào bản đồ để chọn vị trí

## Cấu hình tùy chỉnh

### 1. Thêm thành phố mới
Chỉnh sửa file `vietnam-map-helper.js`:

```javascript
var vietnamCitiesData = {
    // Thêm thành phố mới
    "ThanhPhoMoi": { 
        lat: 10.1234, 
        lng: 106.5678, 
        name: "Thành phố mới" 
    },
    // ... các thành phố khác
};
```

### 2. Thay đổi giới hạn bản đồ
Chỉnh sửa trong file `vietnam-map.js`:

```javascript
var vietnamBounds = {
    north: 23.3934, // Biên giới phía Bắc
    south: 8.5596,  // Biên giới phía Nam
    east: 109.4693, // Biên giới phía Đông
    west: 102.1484  // Biên giới phía Tây
};
```

### 3. Tùy chỉnh giao diện
Chỉnh sửa file `vietnam-map.css` để thay đổi styles.

## Xử lý lỗi

### 1. Bản đồ không hiển thị
- Kiểm tra API Key có hợp lệ không
- Kiểm tra console browser có lỗi JavaScript không
- Đảm bảo các file JavaScript đã được load đúng thứ tự

### 2. Tọa độ không cập nhật
- Kiểm tra các trường form có đúng name attribute không
- Kiểm tra console có lỗi JavaScript không

### 3. Bản đồ hiển thị sai vị trí
- Kiểm tra tọa độ trong `vietnam-map-helper.js`
- Đảm bảo tọa độ nằm trong phạm vi Việt Nam

## Bảo mật

### 1. API Key
- Không commit API Key vào source code
- Sử dụng environment variables
- Giới hạn API Key cho domain cụ thể

### 2. Validation
- Luôn validate tọa độ ở server-side
- Kiểm tra tọa độ có trong phạm vi Việt Nam không

## Hỗ trợ

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra console browser
2. Kiểm tra network tab
3. Đảm bảo tất cả file đã được load
4. Kiểm tra API Key có hoạt động không

## Tương lai

Có thể mở rộng thêm:
- Geocoding để tìm địa chỉ
- Autocomplete cho địa chỉ
- Lưu trữ lịch sử vị trí đã chọn
- Tích hợp với database để lưu tọa độ 