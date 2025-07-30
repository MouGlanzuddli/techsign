# Hướng dẫn Debug TechSign Admin Panel

## Tổng quan
Tài liệu này hướng dẫn cách debug và khắc phục các vấn đề trong hệ thống TechSign Admin Panel.

## Các công cụ Debug đã được thêm

### 1. System Check (Tự động chạy)
- **File**: `system-check.js`
- **Chức năng**: Tự động kiểm tra tình trạng hệ thống khi trang load
- **Báo cáo**: Hiển thị popup báo cáo ở góc phải màn hình
- **Kiểm tra**:
  - DOM elements
  - JavaScript functions
  - Servlet availability
  - Database connection
  - Network connectivity

### 2. Debug Console
- **File**: `debug.js`
- **Chức năng**: Cung cấp các hàm debug trong console
- **Sử dụng**: Mở Developer Tools (F12) và gõ:
  ```javascript
  // Chạy diagnostic đầy đủ
  runDebug()
  
  // Lấy báo cáo debug
  getDebugReport()
  
  // Test section cụ thể
  testSection('account-stats')
  ```

### 3. Fixed Section Loader
- **File**: `fix-section-loader.js`
- **Chức năng**: Phiên bản cải tiến của section loader với nhiều strategy fallback
- **Features**:
  - Multiple loading strategies
  - Better error handling
  - Automatic retry
  - Fallback content

### 4. Test Page
- **File**: `test.html`
- **Chức năng**: Trang test riêng biệt để kiểm tra các servlet
- **Truy cập**: `http://localhost:8080/TechSign/test.html`

## Cách Debug khi gặp lỗi

### Bước 1: Kiểm tra Console
1. Mở Developer Tools (F12)
2. Chuyển sang tab Console
3. Tìm các lỗi màu đỏ
4. Chạy lệnh debug:
   ```javascript
   runSystemCheck()
   ```

### Bước 2: Kiểm tra Network
1. Trong Developer Tools, chuyển sang tab Network
2. Click vào một section trong sidebar
3. Xem các request được gửi
4. Kiểm tra status code và response

### Bước 3: Test từng component
1. Mở trang test: `http://localhost:8080/TechSign/test.html`
2. Test từng servlet một
3. Ghi lại kết quả

### Bước 4: Kiểm tra Database
1. Đảm bảo SQL Server đang chạy
2. Kiểm tra connection string trong `DBConnection.java`
3. Test query trực tiếp trong SQL Server Management Studio

## Các lỗi thường gặp và cách khắc phục

### Lỗi 1: "Section not found"
**Nguyên nhân**: SectionServlet không tìm thấy section
**Khắc phục**:
1. Kiểm tra SectionServlet.java có đúng case trong switch
2. Kiểm tra data-section attribute trong sidebar

### Lỗi 2: "HTTP 404"
**Nguyên nhân**: URL không đúng hoặc servlet không được map
**Khắc phục**:
1. Kiểm tra @WebServlet annotation
2. Kiểm tra basePath detection
3. Kiểm tra web.xml (nếu có)

### Lỗi 3: "Database connection failed"
**Nguyên nhân**: Không kết nối được database
**Khắc phục**:
1. Kiểm tra SQL Server service
2. Kiểm tra connection string
3. Kiểm tra firewall

### Lỗi 4: "JSON parse error"
**Nguyên nhân**: Servlet trả về HTML thay vì JSON
**Khắc phục**:
1. Kiểm tra content-type header
2. Kiểm tra exception handling trong servlet
3. Kiểm tra database query

## Các lệnh Debug hữu ích

### Trong Console Browser:
```javascript
// Kiểm tra base path
console.log('Base path:', window.location.pathname)

// Kiểm tra section loader
console.log('Section loader:', window.fixedSectionLoader)

// Test fetch request
fetch('/TechSign/SectionServlet?action=loadSection&section=account-stats')
  .then(r => r.text())
  .then(console.log)
  .catch(console.error)

// Chạy system check
runSystemCheck()

// Test section cụ thể
testSection('account-stats')
```

### Trong Java:
```java
// Thêm logging vào servlet
System.out.println("Request received: " + request.getParameter("action"));
System.out.println("Section: " + request.getParameter("section"));

// Log database connection
System.out.println("Database connected: " + (conn != null));
```

## Cấu trúc File đã được cải tiến

### JavaScript Files:
- `fix-section-loader.js` - Section loader cải tiến
- `debug.js` - Công cụ debug
- `system-check.js` - Kiểm tra hệ thống
- `statistics-reports.js` - Logic thống kê

### Java Files:
- `SectionServlet.java` - Servlet phục vụ section content
- `StatisticsServlet.java` - Servlet phục vụ dữ liệu thống kê (đã cải tiến)

### Test Files:
- `test.html` - Trang test riêng biệt

## Quy trình Debug được khuyến nghị

1. **Khởi động**: Chạy ứng dụng và mở trang admin
2. **Auto-check**: Đợi system check tự động chạy
3. **Manual test**: Click vào các section trong sidebar
4. **Console check**: Mở Developer Tools và xem console
5. **Network check**: Kiểm tra tab Network
6. **Test page**: Sử dụng test.html để test riêng lẻ
7. **Database check**: Kiểm tra kết nối database
8. **Fix & retry**: Sửa lỗi và test lại

## Liên hệ hỗ trợ

Nếu vẫn gặp vấn đề sau khi thực hiện các bước trên:
1. Chụp màn hình console errors
2. Chụp màn hình system check report
3. Ghi lại các bước đã thực hiện
4. Cung cấp thông tin về môi trường (OS, Java version, SQL Server version) 