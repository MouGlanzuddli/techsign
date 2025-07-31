# Hướng dẫn sử dụng hệ thống hiển thị Jobs trong My Jobs

## Tổng quan
Hệ thống đã được cập nhật để hiển thị đầy đủ các job đã post trong trang "My Jobs". Khi bạn post một job mới, nó sẽ tự động xuất hiện trong danh sách My Jobs.

## Các thay đổi đã thực hiện

### 1. Cập nhật Database
- **File**: `update_job_postings_table.sql`
- **Mục đích**: Thêm các cột mới vào bảng `job_postings` để lưu trữ đầy đủ thông tin job

### 2. Cập nhật JobPostingDao
- **File**: `src/java/dal/JobPostingDao.java`
- **Mục đích**: Hỗ trợ lưu trữ và truy xuất tất cả các trường job mới

### 3. Cập nhật Model JobPosting
- **File**: `src/java/model/JobPosting.java`
- **Mục đích**: Đã có sẵn tất cả các getter/setter cần thiết

### 4. Test Servlet
- **File**: `src/java/controller/TestJobDisplayServlet.java`
- **Mục đích**: Kiểm tra việc hiển thị jobs
- **URL**: `/testJobDisplay`

### 5. Test JSP
- **File**: `web/test-jobs.jsp`
- **Mục đích**: Hiển thị chi tiết tất cả jobs để debug

## Cách sử dụng

### 1. Cập nhật Database
Chạy script SQL để cập nhật bảng:
```sql
-- Chạy file update_job_postings_table.sql trong SQL Server Management Studio
-- hoặc sử dụng command line
sqlcmd -S localhost -d TechSignDB -i update_job_postings_table.sql
```

### 2. Post Job mới
1. Đăng nhập vào hệ thống
2. Vào trang "Post Job" (`company-submit-job.jsp`)
3. Điền đầy đủ thông tin job
4. Chọn vị trí trên bản đồ Việt Nam
5. Click "Post Job"

### 3. Xem Jobs trong My Jobs
1. Sau khi post job thành công, hệ thống sẽ tự động chuyển đến trang "My Jobs"
2. Hoặc vào menu "My Jobs" để xem tất cả jobs đã post
3. Jobs sẽ được hiển thị với đầy đủ thông tin:
   - Tiêu đề job
   - Mô tả
   - Địa điểm
   - Loại công việc
   - Kỹ năng yêu cầu
   - Lương
   - Ngày đăng và hết hạn
   - Trạng thái (Active/Draft/Expired)

### 4. Test và Debug
Để kiểm tra xem jobs có được lưu và hiển thị đúng không:
1. Truy cập: `http://localhost:8080/your-app/testJobDisplay`
2. Xem thông tin debug và danh sách jobs chi tiết
3. Kiểm tra console browser để xem log

## Tính năng chính

### 1. Hiển thị đầy đủ thông tin
- Tất cả các trường từ form post job
- Thông tin địa lý (tọa độ, địa chỉ)
- Thông tin công ty
- Trạng thái job

### 2. Lọc và tìm kiếm
- Tìm kiếm theo tiêu đề, mô tả, kỹ năng
- Lọc theo trạng thái (All/Active/Expired/Draft)
- Sắp xếp theo thời gian đăng

### 3. Quản lý job
- Xem chi tiết job
- Chỉnh sửa job
- Xóa job
- Xem ứng viên

### 4. Tích hợp bản đồ Việt Nam
- Chọn vị trí từ bản đồ
- Tự động cập nhật tọa độ
- Giới hạn trong phạm vi Việt Nam

## Cấu trúc dữ liệu

### Bảng job_postings
```sql
CREATE TABLE job_postings (
    id INT IDENTITY(1,1) PRIMARY KEY,
    company_profile_id INT NOT NULL,
    title VARCHAR(255),
    description TEXT,
    location VARCHAR(255),
    salary_min DECIMAL(10,2),
    salary_max DECIMAL(10,2),
    job_type VARCHAR(50),
    benefits TEXT,
    status VARCHAR(20),
    posted_at DATETIME,
    expires_at DATETIME,
    -- Các trường mới
    job_category VARCHAR(100),
    job_level VARCHAR(100),
    experience VARCHAR(100),
    qualification VARCHAR(100),
    gender VARCHAR(50),
    job_fee_type VARCHAR(50),
    permanent_address VARCHAR(500),
    temporary_address VARCHAR(500),
    country VARCHAR(100),
    state_city VARCHAR(100),
    zip_code VARCHAR(20),
    video_url VARCHAR(500),
    latitude VARCHAR(50),
    longitude VARCHAR(50),
    skills TEXT
);
```

## Xử lý lỗi

### 1. Job không hiển thị
- Kiểm tra database có được cập nhật chưa
- Kiểm tra console server có lỗi SQL không
- Kiểm tra company profile có tồn tại không

### 2. Thông tin job không đầy đủ
- Kiểm tra form post job có điền đầy đủ không
- Kiểm tra JobPostingDao có lưu đúng tất cả trường không

### 3. Bản đồ không hoạt động
- Kiểm tra Google Maps API Key
- Kiểm tra file JavaScript có được load không

## Bảo mật

### 1. Validation
- Tất cả input từ form được validate
- Tọa độ được kiểm tra trong phạm vi Việt Nam
- SQL injection protection

### 2. Authorization
- Chỉ user đã đăng nhập mới có thể post job
- Chỉ company owner mới có thể xem/sửa job của mình

## Tương lai

Có thể mở rộng thêm:
- Thống kê job (views, applications)
- Auto-refresh job status
- Email notification khi job hết hạn
- Bulk operations (delete multiple jobs)
- Job templates
- Advanced search filters

## Hỗ trợ

Nếu gặp vấn đề:
1. Kiểm tra console server và browser
2. Chạy test servlet để debug
3. Kiểm tra database có dữ liệu không
4. Đảm bảo tất cả file đã được deploy đúng 