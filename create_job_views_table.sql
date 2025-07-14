-- Script để tạo bảng job_views để track candidate views
USE [TechSignDB]
GO

-- Kiểm tra xem bảng job_views đã tồn tại chưa
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'job_views')
BEGIN
    -- Tạo bảng job_views
    CREATE TABLE [dbo].[job_views](
        [id] [int] IDENTITY(1,1) NOT NULL,
        [job_posting_id] [int] NOT NULL,
        [candidate_user_id] [int] NOT NULL,
        [viewed_at] [datetime] NOT NULL,
        [ip_address] [varchar](45) NULL,
        [user_agent] [varchar](500) NULL,
        [session_id] [varchar](255) NULL,
        PRIMARY KEY CLUSTERED ([id] ASC)
    ) ON [PRIMARY]
    
    PRINT 'Bảng job_views đã được tạo thành công!'
END
ELSE
BEGIN
    PRINT 'Bảng job_views đã tồn tại!'
END
GO

-- Thêm foreign key constraints nếu chưa có
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_job_views_job_postings')
BEGIN
    ALTER TABLE [dbo].[job_views] WITH CHECK ADD CONSTRAINT [FK_job_views_job_postings] 
        FOREIGN KEY([job_posting_id]) REFERENCES [dbo].[job_postings] ([id])
    PRINT 'Foreign key FK_job_views_job_postings đã được thêm!'
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_job_views_users')
BEGIN
    ALTER TABLE [dbo].[job_views] WITH CHECK ADD CONSTRAINT [FK_job_views_users] 
        FOREIGN KEY([candidate_user_id]) REFERENCES [dbo].[users] ([id])
    PRINT 'Foreign key FK_job_views_users đã được thêm!'
END
GO

-- Thêm indexes nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_job_views_job_posting_id')
BEGIN
    CREATE INDEX [IX_job_views_job_posting_id] ON [dbo].[job_views] ([job_posting_id])
    PRINT 'Index IX_job_views_job_posting_id đã được tạo!'
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_job_views_candidate_user_id')
BEGIN
    CREATE INDEX [IX_job_views_candidate_user_id] ON [dbo].[job_views] ([candidate_user_id])
    PRINT 'Index IX_job_views_candidate_user_id đã được tạo!'
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_job_views_viewed_at')
BEGIN
    CREATE INDEX [IX_job_views_viewed_at] ON [dbo].[job_views] ([viewed_at])
    PRINT 'Index IX_job_views_viewed_at đã được tạo!'
END
GO

-- Thêm default value cho viewed_at nếu chưa có
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_views' AND COLUMN_NAME = 'viewed_at' AND COLUMN_DEFAULT IS NOT NULL)
BEGIN
    ALTER TABLE [dbo].[job_views] ADD CONSTRAINT [DF_job_views_viewed_at] DEFAULT (getdate()) FOR [viewed_at]
    PRINT 'Default value cho viewed_at đã được thêm!'
END
GO

PRINT 'Hoàn thành tạo bảng job_views và các constraints!'
GO 