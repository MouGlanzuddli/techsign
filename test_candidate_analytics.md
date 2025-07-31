# 🧪 Test Candidate Analytics

## 📋 Checklist kiểm tra

### 1. **Database Setup**
- [ ] Chạy script `create_job_views_table.sql` thành công
- [ ] Bảng `job_views` đã được tạo
- [ ] Foreign keys đã được thêm
- [ ] Indexes đã được tạo

### 2. **Compile & Deploy**
- [ ] Build project thành công
- [ ] Deploy lên Tomcat server
- [ ] Không có lỗi compilation

### 3. **Test Flow**

#### **Step 1: Tạo test data**
```sql
-- Tạo test candidate user
INSERT INTO users (role_id, email, phone, password_hash, full_name, is_email_verified, status, created_at, updated_at)
VALUES (2, 'test.candidate@example.com', '0123456789', 'hashed_password', 'Test Candidate', 1, 'active', GETDATE(), GETDATE());

-- Tạo test candidate profile
INSERT INTO candidate_profiles (user_id, headline, summary, experience_years, education_level, ai_score, is_searchable, created_at, updated_at)
VALUES (SCOPE_IDENTITY(), 'Software Developer', 'Experienced in Java development', 3, 'Bachelor', 85.5, 1, GETDATE(), GETDATE());

-- Tạo test job posting
INSERT INTO job_postings (company_profile_id, title, description, location, job_type, status, posted_at)
VALUES (1, 'Test Job', 'Test job description', 'Ho Chi Minh City', 'Full Time', 'open', GETDATE());
```

#### **Step 2: Test Candidate View**
1. Đăng nhập với tài khoản candidate
2. Vào trang job list
3. Click vào một job để xem chi tiết
4. Kiểm tra trong database:
```sql
SELECT * FROM job_views ORDER BY viewed_at DESC;
```

#### **Step 3: Test Analytics Page**
1. Đăng nhập với tài khoản employer
2. Vào menu "Candidate Analytics"
3. Kiểm tra:
   - [ ] Trang load thành công
   - [ ] Hiển thị thống kê
   - [ ] Hiển thị danh sách candidates
   - [ ] Không có lỗi JavaScript

### 4. **Expected Results**

#### **Database**
- Bảng `job_views` có dữ liệu sau khi candidate xem job
- Mỗi view chỉ được lưu 1 lần trong 24h

#### **UI**
- Dashboard hiển thị 3 cards thống kê
- Chart hiển thị views theo ngày
- Danh sách candidates với avatar và thông tin

#### **Security**
- Chỉ employer mới truy cập được
- Candidate không thể xem analytics của employer khác

## 🐛 Troubleshooting

### **Lỗi thường gặp:**

#### 1. **"Table 'job_views' doesn't exist"**
```sql
-- Chạy lại script tạo bảng
EXEC create_job_views_table.sql
```

#### 2. **"CandidateProfile class not found"**
- Kiểm tra file `src/java/model/CandidateProfile.java` đã được tạo
- Clean & rebuild project

#### 3. **"Permission denied"**
- Đảm bảo user đã đăng nhập
- Kiểm tra role_id = 1 (employer)

#### 4. **"No data displayed"**
- Kiểm tra có candidate nào xem job chưa
- Kiểm tra candidate có profile không
- Kiểm tra SQL query trong JobViewDao

### **Debug Commands**
```sql
-- Kiểm tra bảng job_views
SELECT * FROM job_views;

-- Kiểm tra candidate profiles
SELECT * FROM candidate_profiles;

-- Kiểm tra job postings
SELECT * FROM job_postings;

-- Kiểm tra users
SELECT * FROM users WHERE role_id = 2;
```

## ✅ Success Criteria

Tính năng hoạt động thành công khi:
1. ✅ Candidate xem job → dữ liệu được lưu vào `job_views`
2. ✅ Employer truy cập analytics → thấy được thống kê
3. ✅ UI hiển thị đẹp và responsive
4. ✅ Không có lỗi security
5. ✅ Performance tốt (load nhanh)

## 📞 Support

Nếu gặp vấn đề:
1. Kiểm tra console server logs
2. Kiểm tra database connection
3. Verify tất cả files đã được tạo
4. Test với data đơn giản trước 