-- Script để cập nhật bảng job_postings với tất cả các trường cần thiết
USE [TechSignDB]
GO

-- Thêm các cột mới vào bảng job_postings
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'job_category')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [job_category] [varchar](100) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'job_level')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [job_level] [varchar](100) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'experience')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [experience] [varchar](100) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'qualification')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [qualification] [varchar](100) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'gender')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [gender] [varchar](50) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'job_fee_type')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [job_fee_type] [varchar](50) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'permanent_address')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [permanent_address] [varchar](500) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'temporary_address')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [temporary_address] [varchar](500) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'country')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [country] [varchar](100) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'state_city')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [state_city] [varchar](100) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'zip_code')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [zip_code] [varchar](20) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'video_url')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [video_url] [varchar](500) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'latitude')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [latitude] [varchar](50) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'longitude')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [longitude] [varchar](50) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'job_postings' AND COLUMN_NAME = 'skills')
BEGIN
    ALTER TABLE [dbo].[job_postings] ADD [skills] [text] NULL
END

-- Cập nhật JobPostingDao để sử dụng tất cả các trường
PRINT 'Bảng job_postings đã được cập nhật thành công!'
GO 