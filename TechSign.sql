-- Tạo database
CREATE DATABASE TechSignDB;
GO
USE TechSignDB;
GO

-- Bảng roles
CREATE TABLE roles (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Bảng users
CREATE TABLE users (
    id INT PRIMARY KEY IDENTITY,
    role_id INT NOT NULL FOREIGN KEY REFERENCES roles(id),
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    is_email_verified BIT DEFAULT 0,
    is_phone_verified BIT DEFAULT 0,
    avatar_url VARCHAR(500),
    status VARCHAR(20) DEFAULT 'active',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Bảng otp_verifications
CREATE TABLE otp_verifications (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    otp_code VARCHAR(10) NOT NULL,
    action_type VARCHAR(50),
    attempts INT DEFAULT 0,
    expires_at DATETIME NOT NULL,
    is_used BIT DEFAULT 0,
    ip_address VARCHAR(45),
    device_info TEXT,
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng candidate_profiles
CREATE TABLE candidate_profiles (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL UNIQUE FOREIGN KEY REFERENCES users(id),
    headline VARCHAR(255),
    summary TEXT,
    experience_years INT DEFAULT 0,
    education_level VARCHAR(100),
    profile_picture_url VARCHAR(500),
    ai_score FLOAT,
    ai_feedback TEXT,
    is_searchable BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Bảng candidate_cvs
CREATE TABLE candidate_cvs (
    id INT PRIMARY KEY IDENTITY,
    candidate_profile_id INT NOT NULL FOREIGN KEY REFERENCES candidate_profiles(id),
    cv_name VARCHAR(255) NOT NULL,
    cv_url VARCHAR(500),
    thumbnail_url VARCHAR(500),
    is_default BIT DEFAULT 0,
    uploaded_at DATETIME DEFAULT GETDATE()
);

-- Bảng work_experiences
CREATE TABLE work_experiences (
    id INT PRIMARY KEY IDENTITY,
    candidate_cv_id INT NOT NULL FOREIGN KEY REFERENCES candidate_cvs(id),
    job_title VARCHAR(255),
    company_name VARCHAR(255),
    start_date DATE,
    end_date DATE,
    description TEXT,
    achievements TEXT
);

-- Bảng education_details
CREATE TABLE education_details (
    id INT PRIMARY KEY IDENTITY,
    candidate_cv_id INT NOT NULL FOREIGN KEY REFERENCES candidate_cvs(id),
    degree VARCHAR(255),
    major VARCHAR(255),
    university VARCHAR(255),
    start_date DATE,
    end_date DATE,
    gpa DECIMAL(3,2)
);

-- Bảng certifications
CREATE TABLE certifications (
    id INT PRIMARY KEY IDENTITY,
    candidate_cv_id INT NOT NULL FOREIGN KEY REFERENCES candidate_cvs(id),
    name VARCHAR(255),
    issuing_organization VARCHAR(255),
    issue_date DATE,
    expiration_date DATE,
    credential_url VARCHAR(500)
);

-- Bảng skills
CREATE TABLE skills (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Bảng candidate_skills
CREATE TABLE candidate_skills (
    candidate_cv_id INT NOT NULL FOREIGN KEY REFERENCES candidate_cvs(id),
    skill_id INT NOT NULL FOREIGN KEY REFERENCES skills(id),
    proficiency_level VARCHAR(50),
    PRIMARY KEY (candidate_cv_id, skill_id)
);

-- Bảng industries
CREATE TABLE industries (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(255),
    description TEXT,
    created_at DATETIME,
    updated_at DATETIME
);

-- Bảng company_profiles
CREATE TABLE company_profiles (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL UNIQUE FOREIGN KEY REFERENCES users(id),
    industry_id INT FOREIGN KEY REFERENCES industries(id),
    company_name VARCHAR(255),
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

-- Bảng company_industries
CREATE TABLE company_industries (
    company_profile_id INT FOREIGN KEY REFERENCES company_profiles(id),
    industry_id INT FOREIGN KEY REFERENCES industries(id),
    PRIMARY KEY (company_profile_id, industry_id)
);

-- Bảng job_postings
CREATE TABLE job_postings (
    id INT PRIMARY KEY IDENTITY,
    company_profile_id INT NOT NULL FOREIGN KEY REFERENCES company_profiles(id),
    title VARCHAR(255),
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

-- Bảng job_required_skills
CREATE TABLE job_required_skills (
    job_posting_id INT NOT NULL FOREIGN KEY REFERENCES job_postings(id),
    skill_id INT NOT NULL FOREIGN KEY REFERENCES skills(id),
    PRIMARY KEY (job_posting_id, skill_id)
);

-- Bảng applications
CREATE TABLE applications (
    id INT PRIMARY KEY IDENTITY,
    job_posting_id INT NOT NULL FOREIGN KEY REFERENCES job_postings(id),
    candidate_profile_id INT NOT NULL FOREIGN KEY REFERENCES candidate_profiles(id),
    candidate_cv_id INT FOREIGN KEY REFERENCES candidate_cvs(id),
    cover_letter TEXT,
    status VARCHAR(50) DEFAULT 'pending',
    applied_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Bảng interviews
CREATE TABLE interviews (
    id INT PRIMARY KEY IDENTITY,
    application_id INT NOT NULL FOREIGN KEY REFERENCES applications(id),
    interview_date DATETIME,
    location VARCHAR(255),
    interviewer VARCHAR(255),
    status VARCHAR(50) DEFAULT 'scheduled',
    notes TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Bảng connections
CREATE TABLE connections (
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    connected_user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    status VARCHAR(20) DEFAULT 'pending',
    created_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_id, connected_user_id)
);

-- Bảng messages
CREATE TABLE messages (
    id INT PRIMARY KEY IDENTITY,
    sender_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    receiver_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    content TEXT,
    sent_at DATETIME DEFAULT GETDATE(),
    is_read BIT DEFAULT 0
);

-- Bảng groups
CREATE TABLE groups (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(255),
    description TEXT,
    created_by INT NOT NULL FOREIGN KEY REFERENCES users(id),
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng group_members
CREATE TABLE group_members (
    group_id INT NOT NULL FOREIGN KEY REFERENCES groups(id),
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    joined_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (group_id, user_id)
);

-- Bảng job_recommendations
CREATE TABLE job_recommendations (
    id INT PRIMARY KEY IDENTITY,
    candidate_profile_id INT NOT NULL FOREIGN KEY REFERENCES candidate_profiles(id),
    job_posting_id INT NOT NULL FOREIGN KEY REFERENCES job_postings(id),
    recommended_at DATETIME DEFAULT GETDATE()
);

-- Bảng company_reviews
CREATE TABLE company_reviews (
    id INT PRIMARY KEY IDENTITY,
    company_profile_id INT NOT NULL FOREIGN KEY REFERENCES company_profiles(id),
    candidate_profile_id INT NOT NULL FOREIGN KEY REFERENCES candidate_profiles(id),
    rating INT,
    review_text TEXT,
    reviewed_at DATETIME DEFAULT GETDATE()
);

-- Bảng system_feedback
CREATE TABLE system_feedback (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    feedback_text TEXT,
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng user_notifications
CREATE TABLE user_notifications (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    title VARCHAR(255),
    message TEXT,
    is_read BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng bookmarks
CREATE TABLE bookmarks (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    entity_type VARCHAR(50),
    entity_id INT,
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng support_tickets
CREATE TABLE support_tickets (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    subject VARCHAR(255),
    description TEXT,
    status VARCHAR(50) DEFAULT 'open',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Bảng user_follows
CREATE TABLE user_follows (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    entity_type VARCHAR(50),
    entity_id INT,
    followed_at DATETIME DEFAULT GETDATE()
);

-- Bảng featured_companies
CREATE TABLE featured_companies (
    id INT PRIMARY KEY IDENTITY,
    company_profile_id INT NOT NULL FOREIGN KEY REFERENCES company_profiles(id),
    featured_since DATETIME DEFAULT GETDATE(),
    featured_until DATETIME
);

-- Bảng login_history
CREATE TABLE login_history (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL FOREIGN KEY REFERENCES users(id),
    login_time DATETIME DEFAULT GETDATE(),
    ip_address VARCHAR(45),
    device_info TEXT
);

-- Bảng system_logs
CREATE TABLE system_logs (
    id INT PRIMARY KEY IDENTITY,
    user_id INT FOREIGN KEY REFERENCES users(id),
    action VARCHAR(255),
    description TEXT,
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng audit_logs
CREATE TABLE audit_logs (
    id INT PRIMARY KEY IDENTITY,
    user_id INT FOREIGN KEY REFERENCES users(id),
    action_type VARCHAR(100) NOT NULL,
    entity_type VARCHAR(100) NOT NULL,
    entity_id INT NOT NULL,
    old_value TEXT,
    new_value TEXT,
    ip_address VARCHAR(45),
    timestamp DATETIME DEFAULT GETDATE()
);

-- Bảng categories
CREATE TABLE categories (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(255),
    description TEXT,
    icon_url VARCHAR(500),
    created_at DATETIME,
    updated_at DATETIME
);

-- Bảng job_posting_categories
CREATE TABLE job_posting_categories (
    job_posting_id INT NOT NULL FOREIGN KEY REFERENCES job_postings(id),
    category_id INT NOT NULL FOREIGN KEY REFERENCES categories(id),
    PRIMARY KEY (job_posting_id, category_id)
);

-- Bảng permissions
CREATE TABLE permissions (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Bảng role_permissions
CREATE TABLE role_permissions (
    role_id INT NOT NULL FOREIGN KEY REFERENCES roles(id),
    permission_id INT NOT NULL FOREIGN KEY REFERENCES permissions(id),
    PRIMARY KEY (role_id, permission_id)
);

-- Bảng content
CREATE TABLE content (
    id INT PRIMARY KEY IDENTITY,
    title VARCHAR(255),
    body TEXT,
    author_id INT FOREIGN KEY REFERENCES users(id),
    published_at DATETIME
);

-------------------------------------------------------INSERT DATA###########---------------------------------------------------------

-- Insert roles
INSERT INTO roles (name, description) VALUES
('Admin', 'System administrator'),
('Candidate', 'Job seeker'),
('Employer', 'Company representative');

-- Insert users
INSERT INTO users (role_id, email, phone, password_hash, full_name, is_email_verified, status, created_at, updated_at) VALUES
(1, 'admin@example.com', '1234567890', 'hashed_password_admin', 'Admin User', 1, 'active', GETDATE(), GETDATE()),
(2, 'candidate@example.com', '0987654321', 'hashed_password_candidate', 'John Doe', 1, 'active', GETDATE(), GETDATE()),
(3, 'employer@example.com', '0123456789', 'hashed_password_employer', 'Acme Corp HR', 1, 'active', GETDATE(), GETDATE());

-- Insert candidate profile
INSERT INTO candidate_profiles (user_id, headline, summary, experience_years, education_level, ai_score, is_searchable, created_at, updated_at)
VALUES (2, 'Software Developer', 'Experienced in web development', 3, 'Bachelor', 85.5, 1, GETDATE(), GETDATE());

-- Insert candidate CV
INSERT INTO candidate_cvs (candidate_profile_id, cv_name, cv_url, is_default, uploaded_at)
VALUES (1, 'John_Doe_CV.pdf', 'https://example.com/cv/johndoe.pdf', 1, GETDATE());

-- Insert skills
INSERT INTO skills (name) VALUES
('JavaScript'), ('Python'), ('SQL');

-- Insert candidate skills
INSERT INTO candidate_skills (candidate_cv_id, skill_id, proficiency_level) VALUES
(1, 1, 'Advanced'),
(1, 2, 'Intermediate'),
(1, 3, 'Advanced');

-- Work experience
INSERT INTO work_experiences (candidate_cv_id, job_title, company_name, start_date, end_date, description, achievements)
VALUES (1, 'Web Developer', 'ABC Corp', '2021-01-01', '2023-01-01', 'Developed web applications', 'Improved performance by 30%');

-- Education
INSERT INTO education_details (candidate_cv_id, degree, major, university, start_date, end_date, gpa)
VALUES (1, 'Bachelor', 'Computer Science', 'Tech University', '2017-09-01', '2021-06-30', 3.80);

-- Industry
INSERT INTO industries (name, description, created_at, updated_at)
VALUES ('Information Technology', 'IT Industry', GETDATE(), GETDATE());

-- Company profile
INSERT INTO company_profiles (user_id, industry_id, company_name, website, description, address, phone, is_featured, is_searchable, created_at, updated_at)
VALUES (3, 1, 'Acme Corp', 'https://acme.example.com', 'Leading tech company', '123 Tech Street', '0123456789', 1, 1, GETDATE(), GETDATE());

-- Job posting
INSERT INTO job_postings (company_profile_id, title, description, location, salary_min, salary_max, job_type, benefits, status, posted_at, expires_at)
VALUES (1, 'Frontend Developer', 'React developer needed', 'Remote', 800, 1500, 'Full-time', 'Health insurance, Remote work', 'open', GETDATE(), DATEADD(day, 30, GETDATE()));

-- Job required skills
INSERT INTO job_required_skills (job_posting_id, skill_id) VALUES (1, 1), (1, 3);

-- Application
INSERT INTO applications (job_posting_id, candidate_profile_id, candidate_cv_id, cover_letter, status, applied_at, updated_at)
VALUES (1, 1, 1, 'I am excited to apply...', 'pending', GETDATE(), GETDATE());

-- Interview
INSERT INTO interviews (application_id, interview_date, location, interviewer, status, created_at, updated_at)
VALUES (1, DATEADD(day, 7, GETDATE()), 'Online', 'Jane HR', 'scheduled', GETDATE(), GETDATE());

-- Message
INSERT INTO messages (sender_id, receiver_id, content, sent_at, is_read)
VALUES (2, 3, 'Hi, I have applied for the job.', GETDATE(), 0);

-- Notification
INSERT INTO user_notifications (user_id, title, message, is_read, created_at)
VALUES (2, 'Application Received', 'Your application has been received.', 0, GETDATE());

-- Recommendation
INSERT INTO job_recommendations (candidate_profile_id, job_posting_id, recommended_at)
VALUES (1, 1, GETDATE());

-- Feedback
INSERT INTO system_feedback (user_id, feedback_text, created_at)
VALUES (2, 'Great platform!', GETDATE());

-- Login history
INSERT INTO login_history (user_id, login_time, ip_address, device_info)
VALUES (2, GETDATE(), '192.168.1.2', 'Chrome on Windows');

-- System log
INSERT INTO system_logs (user_id, action, description, created_at)
VALUES (2, 'Login', 'User logged in', GETDATE());

