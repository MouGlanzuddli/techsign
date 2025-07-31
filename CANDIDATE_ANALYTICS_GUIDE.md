# 📊 Candidate Analytics - Hướng dẫn sử dụng

## 🎯 Tổng quan tính năng

Tính năng **Candidate Analytics** cho phép nhà tuyển dụng theo dõi và phân tích thông tin về các ứng viên đã xem bài đăng tuyển dụng của họ. Đây là một công cụ analytics mạnh mẽ giúp tối ưu hóa chiến lược tuyển dụng.

## 🚀 Cách hoạt động

### 1. **Tracking tự động**
- Khi một candidate (đã đăng nhập) xem chi tiết job posting
- Hệ thống tự động lưu thông tin:
  - ID của candidate
  - ID của job posting
  - Thời gian xem
  - IP address
  - User agent
  - Session ID

### 2. **Chống spam**
- Chỉ lưu 1 view mỗi 24h cho mỗi candidate-job combination
- Tránh việc spam refresh để tăng số liệu

### 3. **Phân quyền**
- Chỉ employer mới có thể xem analytics
- Candidate không thể xem thông tin của candidate khác

## 📋 Các tính năng chính

### 📈 **Dashboard Analytics**
- **Tổng số ứng viên đã xem**: Số lượng candidate unique đã xem job postings
- **Lượt xem 7 ngày qua**: Tổng số lượt xem trong 7 ngày gần nhất
- **Ngày có hoạt động**: Số ngày có candidate xem job postings

### 📊 **Thống kê theo ngày**
- Hiển thị số lượt xem theo từng ngày
- Giúp phân tích xu hướng và hiệu quả của job postings

### 👥 **Danh sách ứng viên**
- Thông tin chi tiết của từng candidate:
  - Tên và email
  - Headline (tiêu đề công việc)
  - Số năm kinh nghiệm
  - Thời gian xem gần nhất
  - Link xem hồ sơ chi tiết

## 🛠️ Cài đặt và sử dụng

### 1. **Cài đặt Database**
Chạy script SQL để tạo bảng `job_views`:

```sql
-- Chạy file: create_job_views_table.sql
-- Hoặc chạy trực tiếp trong SQL Server Management Studio
```

**Cách chạy:**
1. Mở SQL Server Management Studio
2. Kết nối đến database TechSignDB
3. Mở file `create_job_views_table.sql`
4. Click Execute hoặc nhấn F5

### 2. **Truy cập tính năng**
1. Đăng nhập với tài khoản **Employer**
2. Vào **Dashboard** → **Candidate Analytics**
3. Hoặc truy cập trực tiếp: `/CandidateViewListServlet`

### 3. **URL Endpoints**
- **GET** `/CandidateViewListServlet` - Hiển thị trang analytics
- **GET** `/candidate-view-list` - URL thân thiện

## 📁 Cấu trúc file

```
src/java/
├── controller/
│   └── CandidateViewListServlet.java    # Servlet xử lý request
├── dal/
│   └── JobViewDao.java                  # Data Access Object
└── model/
    └── JobView.java                     # Model class

web/
├── company-candidate-list.jsp           # Giao diện hiển thị
└── WEB-INF/
    └── web.xml                          # Cấu hình servlet
```

## 🔧 Cấu hình

### Database Schema
```sql
CREATE TABLE job_views (
    id INT IDENTITY(1,1) PRIMARY KEY,
    job_posting_id INT NOT NULL,
    candidate_user_id INT NOT NULL,
    viewed_at DATETIME NOT NULL DEFAULT GETDATE(),
    ip_address VARCHAR(45),
    user_agent VARCHAR(500),
    session_id VARCHAR(255),
    FOREIGN KEY (job_posting_id) REFERENCES job_postings(id),
    FOREIGN KEY (candidate_user_id) REFERENCES users(id)
);
```

### Indexes cho Performance
```sql
CREATE INDEX IX_job_views_job_posting_id ON job_views (job_posting_id);
CREATE INDEX IX_job_views_candidate_user_id ON job_views (candidate_user_id);
CREATE INDEX IX_job_views_viewed_at ON job_views (viewed_at);
```

## 📊 API Methods

### JobViewDao
- `saveJobView(JobView)` - Lưu thông tin view
- `hasViewedRecently(jobId, userId)` - Kiểm tra view gần đây
- `getCandidatesViewedCompanyJobs(companyUserId, limit)` - Lấy danh sách candidates
- `getViewsStatisticsByDate(companyUserId, days)` - Thống kê theo ngày

## 🎨 Giao diện

### Responsive Design
- Tương thích mobile và desktop
- Bootstrap 5 framework
- Font Awesome icons
- Modern UI/UX design

### Color Scheme
- Primary: `#17ac6a` (Green)
- Secondary: `#28a745` (Dark Green)
- Background: `#f8f9fa` (Light Gray)

## 🔒 Bảo mật

### Privacy Protection
- Chỉ lưu thông tin cần thiết
- Không lưu sensitive data
- IP address được ẩn một phần
- Session timeout tự động

### Access Control
- Role-based access (chỉ employer)
- Session validation
- SQL injection prevention
- XSS protection

## 🚀 Tối ưu hóa

### Performance
- Database indexing
- Query optimization
- Pagination support
- Caching strategies

### Scalability
- Modular architecture
- Separation of concerns
- Easy to extend
- Configurable limits

## 📝 Logs và Monitoring

### Audit Trail
- Tất cả views được log
- Timestamp tracking
- User session tracking
- Error logging

### Analytics Data
- View patterns
- Peak usage times
- Popular job categories
- Candidate engagement metrics

## 🔄 Future Enhancements

### Planned Features
- [ ] Email notifications for new views
- [ ] Advanced filtering options
- [ ] Export to CSV/PDF
- [ ] Real-time analytics
- [ ] A/B testing support
- [ ] Integration with email campaigns

### Technical Improvements
- [ ] Redis caching
- [ ] Background job processing
- [ ] API rate limiting
- [ ] Advanced analytics dashboard
- [ ] Machine learning insights

## 🐛 Troubleshooting

### Common Issues
1. **Không hiển thị data**: Kiểm tra database connection
2. **Permission denied**: Đảm bảo user là employer
3. **Performance slow**: Kiểm tra database indexes
4. **Missing candidates**: Kiểm tra candidate profiles

### Debug Mode
```java
// Enable debug logging
System.setProperty("debug.jobviews", "true");
```

## 📞 Support

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra logs trong console
2. Verify database connection
3. Test với user role employer
4. Contact development team

---

**Version**: 1.0.0  
**Last Updated**: 2024  
**Author**: TechSign Development Team 