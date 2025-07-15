-- Database Tables for Admin Screen Backend
-- Post Approval and Job Management System

-- Bảng industries
CREATE TABLE industries (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Bảng company_profiles
CREATE TABLE company_profiles (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL UNIQUE FOREIGN KEY REFERENCES users(id),
    industry_id INT FOREIGN KEY REFERENCES industries(id),
    company_name VARCHAR(255) NOT NULL,
    website VARCHAR(255),
    description TEXT,
    address TEXT,
    phone VARCHAR(20),
    logo_url VARCHAR(500),
    banner_url VARCHAR(500),
    icon_url VARCHAR(500),
    is_featured BIT DEFAULT 0,
    is_searchable BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Bảng company_industries (many-to-many relationship)
CREATE TABLE company_industries (
    company_profile_id INT FOREIGN KEY REFERENCES company_profiles(id),
    industry_id INT FOREIGN KEY REFERENCES industries(id),
    PRIMARY KEY (company_profile_id, industry_id)
);

-- Bảng job_postings
CREATE TABLE job_postings (
    id INT PRIMARY KEY IDENTITY,
    company_profile_id INT NOT NULL FOREIGN KEY REFERENCES company_profiles(id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    salary_min DECIMAL(10,2),
    salary_max DECIMAL(10,2),
    job_type VARCHAR(50),
    benefits TEXT,
    status VARCHAR(20) DEFAULT 'open',
    posted_at DATETIME DEFAULT GETDATE(),
    expires_at DATETIME
);

-- Bảng categories
CREATE TABLE categories (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    icon_url VARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Bảng job_posting_categories (many-to-many relationship)
CREATE TABLE job_posting_categories (
    job_posting_id INT NOT NULL FOREIGN KEY REFERENCES job_postings(id),
    category_id INT NOT NULL FOREIGN KEY REFERENCES categories(id),
    PRIMARY KEY (job_posting_id, category_id)
);

-- Bảng posts (for post approval system)
CREATE TABLE posts (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    title VARCHAR(255) NOT NULL,
    content TEXT,
    category VARCHAR(100),
    status VARCHAR(20) DEFAULT 'pending', -- pending, approved, rejected, draft
    location VARCHAR(255),
    salary VARCHAR(100),
    requirements TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Insert sample data for industries
INSERT INTO industries (name, description) VALUES 
('Technology', 'Công nghệ thông tin và phần mềm'),
('Finance', 'Tài chính và ngân hàng'),
('Healthcare', 'Y tế và chăm sóc sức khỏe'),
('Education', 'Giáo dục và đào tạo'),
('Manufacturing', 'Sản xuất và công nghiệp'),
('Retail', 'Bán lẻ và thương mại'),
('Marketing', 'Marketing và quảng cáo'),
('Consulting', 'Tư vấn và dịch vụ');

-- Insert sample data for categories
INSERT INTO categories (name, description, icon_url) VALUES 
('Full-time', 'Công việc toàn thời gian', '/icons/fulltime.png'),
('Part-time', 'Công việc bán thời gian', '/icons/parttime.png'),
('Contract', 'Công việc theo hợp đồng', '/icons/contract.png'),
('Internship', 'Thực tập', '/icons/internship.png'),
('Remote', 'Làm việc từ xa', '/icons/remote.png'),
('Entry Level', 'Cấp độ mới bắt đầu', '/icons/entry.png'),
('Senior', 'Cấp độ cao cấp', '/icons/senior.png'),
('Management', 'Quản lý', '/icons/management.png');

-- Insert sample data for posts (assuming user_id 1 exists)
INSERT INTO posts (user_id, title, content, category, status, location, salary, requirements, created_at) VALUES 
(1, 'Lập trình viên Java Senior', 'Chúng tôi đang tìm kiếm một lập trình viên Java Senior có kinh nghiệm để tham gia vào dự án phát triển hệ thống quản lý doanh nghiệp. Vị trí này sẽ làm việc trong môi trường năng động và có cơ hội thăng tiến.', 'Technology', 'pending', 'Hà Nội', '25,000,000 - 35,000,000 VND', 'Kinh nghiệm 3-5 năm với Java, Spring Framework, MySQL. Có kiến thức về microservices và cloud computing.', GETDATE()),
(1, 'Nhân viên Marketing Digital', 'Công ty chúng tôi cần tuyển nhân viên Marketing Digital để phụ trách các chiến dịch quảng cáo online và quản lý mạng xã hội.', 'Marketing', 'pending', 'TP. Hồ Chí Minh', '15,000,000 - 20,000,000 VND', 'Tốt nghiệp đại học chuyên ngành Marketing hoặc liên quan. Có kinh nghiệm về Facebook Ads, Google Ads.', GETDATE()),
(1, 'Kế toán trưởng', 'Tuyển dụng kế toán trưởng cho công ty tài chính với quy mô 100+ nhân viên. Vị trí này sẽ phụ trách toàn bộ hoạt động kế toán và báo cáo tài chính.', 'Finance', 'approved', 'Hà Nội', '30,000,000 - 40,000,000 VND', 'Có chứng chỉ CPA, kinh nghiệm 5+ năm trong lĩnh vực kế toán. Thành thạo các phần mềm kế toán.', GETDATE()),
(1, 'Bác sĩ nội khoa', 'Bệnh viện tư nhân cần tuyển bác sĩ nội khoa có kinh nghiệm để làm việc tại khoa nội tổng hợp.', 'Healthcare', 'rejected', 'Đà Nẵng', '40,000,000 - 50,000,000 VND', 'Tốt nghiệp đại học Y, có chứng chỉ hành nghề. Kinh nghiệm 3+ năm trong lĩnh vực nội khoa.', GETDATE()),
(1, 'Giáo viên tiếng Anh', 'Trung tâm Anh ngữ cần tuyển giáo viên tiếng Anh để giảng dạy cho học sinh các cấp độ khác nhau.', 'Education', 'pending', 'Hà Nội', '20,000,000 - 25,000,000 VND', 'Tốt nghiệp đại học chuyên ngành tiếng Anh, có chứng chỉ IELTS 7.0+. Kinh nghiệm giảng dạy 2+ năm.', GETDATE()),
(1, 'Quản lý sản xuất', 'Nhà máy sản xuất cần tuyển quản lý sản xuất để điều hành và quản lý quy trình sản xuất.', 'Manufacturing', 'draft', 'Bình Dương', '25,000,000 - 30,000,000 VND', 'Tốt nghiệp đại học kỹ thuật, kinh nghiệm 5+ năm trong lĩnh vực sản xuất. Có kiến thức về Lean Manufacturing.', GETDATE()),
(1, 'Nhân viên bán hàng', 'Cửa hàng bán lẻ cần tuyển nhân viên bán hàng để phục vụ khách hàng và tư vấn sản phẩm.', 'Retail', 'pending', 'TP. Hồ Chí Minh', '8,000,000 - 12,000,000 VND', 'Tốt nghiệp THPT trở lên, có kỹ năng giao tiếp tốt. Kinh nghiệm bán hàng là một lợi thế.', GETDATE()),
(1, 'Tư vấn viên', 'Công ty tư vấn cần tuyển tư vấn viên để hỗ trợ khách hàng về các dịch vụ tư vấn doanh nghiệp.', 'Consulting', 'approved', 'Hà Nội', '18,000,000 - 25,000,000 VND', 'Tốt nghiệp đại học kinh tế hoặc quản trị kinh doanh. Có kỹ năng phân tích và tư vấn.', GETDATE());

-- Create indexes for better performance
CREATE INDEX idx_company_profiles_user_id ON company_profiles(user_id);
CREATE INDEX idx_company_profiles_industry_id ON company_profiles(industry_id);
CREATE INDEX idx_job_postings_company_profile_id ON job_postings(company_profile_id);
CREATE INDEX idx_job_postings_status ON job_postings(status);
CREATE INDEX idx_job_postings_posted_at ON job_postings(posted_at);
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_status ON posts(status);
CREATE INDEX idx_posts_created_at ON posts(created_at);
CREATE INDEX idx_industries_name ON industries(name);
CREATE INDEX idx_categories_name ON categories(name); 