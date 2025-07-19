USE [master]
GO
/****** Object:  Database [TechSignDB]    Script Date: 6/13/2025 9:04:14 PM ******/
CREATE DATABASE [TechSignDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TechSignDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TechSignDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TechSignDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TechSignDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TechSignDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TechSignDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TechSignDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TechSignDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TechSignDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TechSignDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TechSignDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TechSignDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TechSignDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TechSignDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TechSignDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TechSignDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TechSignDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TechSignDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TechSignDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TechSignDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TechSignDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TechSignDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TechSignDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TechSignDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TechSignDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TechSignDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TechSignDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TechSignDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TechSignDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TechSignDB] SET  MULTI_USER 
GO
ALTER DATABASE [TechSignDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TechSignDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TechSignDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TechSignDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TechSignDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TechSignDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TechSignDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [TechSignDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200)
GO
USE [TechSignDB]
GO
/****** Object:  Table [dbo].[applications]    Script Date: 6/13/2025 9:04:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[applications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[job_posting_id] [int] NOT NULL,
	[candidate_profile_id] [int] NOT NULL,
	[candidate_cv_id] [int] NULL,
	[cover_letter] [text] NULL,
	[status] [varchar](50) NULL,
	[applied_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[audit_logs]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[audit_logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[action_type] [varchar](100) NOT NULL,
	[entity_type] [varchar](100) NOT NULL,
	[entity_id] [int] NOT NULL,
	[old_value] [text] NULL,
	[new_value] [text] NULL,
	[ip_address] [varchar](45) NULL,
	[timestamp] [datetime] NULL,
	[severity] [varchar](20) DEFAULT 'INFO',
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/*Add Mức độ cảnh báo  */



/****** Object:  Table [dbo].[bookmarks]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bookmarks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[entity_type] [varchar](50) NULL,
	[entity_id] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[candidate_cvs]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidate_cvs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_profile_id] [int] NOT NULL,
	[cv_name] [varchar](255) NOT NULL,
	[cv_url] [varchar](500) NULL,
	[thumbnail_url] [varchar](500) NULL,
	[is_default] [bit] NULL,
	[uploaded_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[candidate_profiles]    Script Date: 6/13/2025 9:04:16 PM ******/
DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql += 'ALTER TABLE [' + OBJECT_SCHEMA_NAME(parent_object_id) + '].[' + OBJECT_NAME(parent_object_id) + '] DROP CONSTRAINT [' + name + '];'
FROM sys.foreign_keys
WHERE referenced_object_id = OBJECT_ID('dbo.candidate_profiles');

EXEC sp_executesql @sql;
GO
IF OBJECT_ID('dbo.candidate_profiles', 'U') IS NOT NULL
    DROP TABLE dbo.candidate_profiles;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[candidate_profiles] (
	[id] INT IDENTITY(1,1) NOT NULL,
	[user_id] INT NOT NULL,
	[experience_years] INT NULL,
	[address] VARCHAR(500) NULL,
	[education_level] VARCHAR(100) NULL,
	[profile_picture_url] VARCHAR(500) NULL,
	[job_title] VARCHAR(255) NULL,
	[ai_score] [float] NULL,
	[ai_feedback] [text] NULL,
	[is_searchable] [bit] NULL,
	[created_at] DATETIME NULL,
	[updated_at] DATETIME NULL,
	
	PRIMARY KEY CLUSTERED (
		[id] ASC
	) WITH (
		PAD_INDEX = OFF, 
		STATISTICS_NORECOMPUTE = OFF, 
		IGNORE_DUP_KEY = OFF, 
		ALLOW_ROW_LOCKS = ON, 
		ALLOW_PAGE_LOCKS = ON, 
		OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
	) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[candidate_skills]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[candidate_skills](
	[candidate_cv_id] [int] NOT NULL,
	[skill_id] [int] NOT NULL,
	[proficiency_level] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[candidate_cv_id] ASC,
	[skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NULL,
	[description] [text] NULL,
	[icon_url] [varchar](500) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[certifications]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[certifications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_cv_id] [int] NOT NULL,
	[name] [varchar](255) NULL,
	[issuing_organization] [varchar](255) NULL,
	[issue_date] [date] NULL,
	[expiration_date] [date] NULL,
	[credential_url] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[company_industries]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_industries](
	[company_profile_id] [int] NOT NULL,
	[industry_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[company_profile_id] ASC,
	[industry_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[company_profiles]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_profiles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[industry_id] [int] NULL,
	[company_name] [varchar](255) NULL,
	[website] [varchar](255) NULL,
	[description] [text] NULL,
	[address] [text] NULL,
	[phone] [varchar](20) NULL,
	[logo_url] [varchar](500) NULL,
	[banner_url] [varchar](500) NULL,
	[icon_url] [varchar](500) NULL,
	[is_featured] [bit] NULL,
	[is_searchable] [bit] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[company_reviews]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_reviews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_profile_id] [int] NOT NULL,
	[candidate_profile_id] [int] NOT NULL,
	[rating] [int] NULL,
	[review_text] [text] NULL,
	[reviewed_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[connections]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[connections](
	[user_id] [int] NOT NULL,
	[connected_user_id] [int] NOT NULL,
	[status] [varchar](20) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[connected_user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[content]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[content](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NULL,
	[body] [text] NULL,
	[author_id] [int] NULL,
	[published_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[education_details]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[education_details](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_cv_id] [int] NOT NULL,
	[degree] [varchar](255) NULL,
	[major] [varchar](255) NULL,
	[university] [varchar](255) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[gpa] [decimal](3, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[featured_companies]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[featured_companies](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_profile_id] [int] NOT NULL,
	[featured_since] [datetime] NULL,
	[featured_until] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[group_members]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[group_members](
	[group_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[joined_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[group_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[groups]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[groups](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NULL,
	[description] [text] NULL,
	[created_by] [int] NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[industries]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[industries](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NULL,
	[description] [text] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[interviews]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[interviews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[application_id] [int] NOT NULL,
	[interview_date] [datetime] NULL,
	[location] [varchar](255) NULL,
	[interviewer] [varchar](255) NULL,
	[status] [varchar](50) NULL,
	[notes] [text] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_posting_categories]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_posting_categories](
	[job_posting_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[job_posting_id] ASC,
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_postings]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_postings](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_profile_id] [int] NOT NULL,
	[title] [varchar](255) NULL,
	[description] [text] NULL,
	[location] [varchar](255) NULL,
	[salary_min] [decimal](10, 2) NULL,
	[salary_max] [decimal](10, 2) NULL,
	[job_type] [varchar](50) NULL,
	[benefits] [text] NULL,
	[status] [varchar](20) NULL,
	[posted_at] [datetime] NULL,
	[expires_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_recommendations]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_recommendations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_profile_id] [int] NOT NULL,
	[job_posting_id] [int] NOT NULL,
	[recommended_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[job_required_skills]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_required_skills](
	[job_posting_id] [int] NOT NULL,
	[skill_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[job_posting_id] ASC,
	[skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[login_history]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[login_history](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[login_time] [datetime] NULL,
	[ip_address] [varchar](45) NULL,
	[device_info] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[messages]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[messages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sender_id] [int] NOT NULL,
	[receiver_id] [int] NOT NULL,
	[content] [text] NULL,
	[sent_at] [datetime] NULL,
	[is_read] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[otp_verifications]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[otp_verifications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[otp_code] [varchar](10) NOT NULL,
	[action_type] [varchar](50) NULL,
	[attempts] [int] NULL,
	[expires_at] [datetime] NOT NULL,
	[is_used] [bit] NULL,
	[ip_address] [varchar](45) NULL,
	[device_info] [text] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[permissions]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permissions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role_permissions]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role_permissions](
	[role_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[skills]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[skills](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[support_tickets]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[support_tickets](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[subject] [varchar](255) NULL,
	[description] [text] NULL,
	[status] [varchar](50) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[system_feedback]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[system_feedback](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[feedback_text] [text] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[system_logs]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[system_logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[action] [varchar](255) NULL,
	[description] [text] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_follows]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_follows](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[entity_type] [varchar](50) NULL,
	[entity_id] [int] NULL,
	[followed_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_notifications]    Script Date: 6/13/2025 9:04:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_notifications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[title] [varchar](255) NULL,
	[message] [text] NULL,
	[is_read] [bit] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 6/13/2025 9:04:16 PM ******/
DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql += 'ALTER TABLE [' + OBJECT_SCHEMA_NAME(parent_object_id) + '].[' + OBJECT_NAME(parent_object_id) + '] DROP CONSTRAINT [' + name + '];'
FROM sys.foreign_keys
WHERE referenced_object_id = OBJECT_ID('dbo.users');

EXEC sp_executesql @sql;
GO

IF OBJECT_ID('dbo.users', 'U') IS NOT NULL
    DROP TABLE dbo.users;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NOT NULL,
	[email] [varchar](255) NOT NULL,
	[phone] [varchar](20) NULL,
	[password_hash] [varchar](255) NOT NULL,
	[full_name] [varchar](255) NULL,
	[is_email_verified] [bit] NULL,
	[is_phone_verified] [bit] NULL,
	[avatar_url] [varchar](500) NULL,
	[status] [varchar](20) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[work_experiences]    Script Date: 6/13/2025 9:04:16 PM ******/
DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql += 'ALTER TABLE [' + OBJECT_SCHEMA_NAME(parent_object_id) + '].[' + OBJECT_NAME(parent_object_id) + '] DROP CONSTRAINT [' + name + '];'
FROM sys.foreign_keys
WHERE referenced_object_id = OBJECT_ID('dbo.work_experiences');

EXEC sp_executesql @sql;
GO
IF OBJECT_ID('dbo.work_experiences', 'U') IS NOT NULL
    DROP TABLE dbo.work_experiences;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[work_experiences](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[candidate_cv_id] [int] NOT NULL,
	[job_title] [varchar](255) NULL,
	[company_name] [varchar](255) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[description] [text] NULL,
	[achievements] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[applications] 
([job_posting_id], [candidate_profile_id], [candidate_cv_id], [cover_letter], [status], [applied_at], [updated_at]) 
VALUES (1, 1, 1, N'I am excited to apply...', N'pending', 
CAST(N'2025-06-10T14:23:09.470' AS DateTime), 
CAST(N'2025-06-10T14:23:09.470' AS DateTime))

INSERT [dbo].[candidate_cvs] 
([candidate_profile_id], [cv_name], [cv_url], [thumbnail_url], [is_default], [uploaded_at]) 
VALUES (1, N'John_Doe_CV.pdf', N'https://example.com/cv/johndoe.pdf', NULL, 1, CAST(N'2025-06-10T14:22:34.583' AS DateTime))

INSERT [dbo].[candidate_profiles] ([user_id],[experience_years],[address], [education_level], [profile_picture_url],[job_title], [ai_score], [ai_feedback], [is_searchable], [created_at], [updated_at]) 
VALUES (3, N'Software Developer', N'Experienced in web development', 3, N'Bachelor', NULL, 85.5, NULL, 1, CAST(N'2025-06-10T14:22:30.290' AS DateTime), CAST(N'2025-06-10T14:22:30.290' AS DateTime));
INSERT [dbo].[candidate_skills] ([candidate_cv_id], [skill_id], [proficiency_level]) VALUES (1, 1, N'Advanced')
INSERT [dbo].[candidate_skills] ([candidate_cv_id], [skill_id], [proficiency_level]) VALUES (1, 2, N'Intermediate')
INSERT [dbo].[candidate_skills] ([candidate_cv_id], [skill_id], [proficiency_level]) VALUES (1, 3, N'Advanced')
GO

SET IDENTITY_INSERT [dbo].[company_profiles] ON 

INSERT [dbo].[company_profiles] ([id], [user_id], [industry_id], [company_name], [website], [description], [address], [phone], [logo_url], [banner_url], [icon_url], [is_featured], [is_searchable], [created_at], [updated_at]) VALUES (1, 3, 1, N'Acme Corp', N'https://acme.example.com', N'Leading tech company', N'123 Tech Street', N'0123456789', NULL, NULL, NULL, 1, 1, CAST(N'2025-06-10T14:22:59.257' AS DateTime), CAST(N'2025-06-10T14:22:59.257' AS DateTime))
SET IDENTITY_INSERT [dbo].[company_profiles] OFF
GO
SET IDENTITY_INSERT [dbo].[education_details] ON 

INSERT [dbo].[education_details] ([id], [candidate_cv_id], [degree], [major], [university], [start_date], [end_date], [gpa]) VALUES (1, 1, N'Bachelor', N'Computer Science', N'Tech University', CAST(N'2017-09-01' AS Date), CAST(N'2021-06-30' AS Date), CAST(3.80 AS Decimal(3, 2)))
SET IDENTITY_INSERT [dbo].[education_details] OFF
GO
SET IDENTITY_INSERT [dbo].[industries] ON 

INSERT [dbo].[industries] ([id], [name], [description], [created_at], [updated_at]) VALUES (1, N'Information Technology', N'IT Industry', CAST(N'2025-06-10T14:22:54.247' AS DateTime), CAST(N'2025-06-10T14:22:54.247' AS DateTime))
SET IDENTITY_INSERT [dbo].[industries] OFF
GO
SET IDENTITY_INSERT [dbo].[interviews] ON 

INSERT [dbo].[interviews] ([id], [application_id], [interview_date], [location], [interviewer], [status], [notes], [created_at], [updated_at]) VALUES (1, 1, CAST(N'2025-06-17T14:23:12.830' AS DateTime), N'Online', N'Jane HR', N'scheduled', NULL, CAST(N'2025-06-10T14:23:12.830' AS DateTime), CAST(N'2025-06-10T14:23:12.830' AS DateTime))
SET IDENTITY_INSERT [dbo].[interviews] OFF
GO
SET IDENTITY_INSERT [dbo].[job_postings] ON 

INSERT [dbo].[job_postings] ([id], [company_profile_id], [title], [description], [location], [salary_min], [salary_max], [job_type], [benefits], [status], [posted_at], [expires_at]) VALUES (1, 1, N'Frontend Developer', N'React developer needed', N'Remote', CAST(800.00 AS Decimal(10, 2)), CAST(1500.00 AS Decimal(10, 2)), N'Full-time', N'Health insurance, Remote work', N'open', CAST(N'2025-06-10T14:23:03.010' AS DateTime), CAST(N'2025-07-10T14:23:03.010' AS DateTime))
SET IDENTITY_INSERT [dbo].[job_postings] OFF
GO
SET IDENTITY_INSERT [dbo].[job_recommendations] ON 

INSERT [dbo].[job_recommendations] ([id], [candidate_profile_id], [job_posting_id], [recommended_at]) VALUES (1, 1, 1, CAST(N'2025-06-10T14:23:25.687' AS DateTime))
SET IDENTITY_INSERT [dbo].[job_recommendations] OFF
GO
INSERT [dbo].[job_required_skills] ([job_posting_id], [skill_id]) VALUES (1, 1)
INSERT [dbo].[job_required_skills] ([job_posting_id], [skill_id]) VALUES (1, 3)
GO
SET IDENTITY_INSERT [dbo].[login_history] ON 

INSERT [dbo].[login_history] ([id], [user_id], [login_time], [ip_address], [device_info]) VALUES (1, 2, CAST(N'2025-06-10T14:23:31.010' AS DateTime), N'192.168.1.2', N'Chrome on Windows')
SET IDENTITY_INSERT [dbo].[login_history] OFF
GO
SET IDENTITY_INSERT [dbo].[messages] ON 

INSERT [dbo].[messages] ([id], [sender_id], [receiver_id], [content], [sent_at], [is_read]) VALUES (1, 2, 3, N'Hi, I have applied for the job.', CAST(N'2025-06-10T14:23:17.180' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[messages] OFF
GO
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([id], [name], [description]) VALUES (1, N'Admin', N'System administrator')
INSERT [dbo].[roles] ([id], [name], [description]) VALUES (2, N'Candidate', N'Job seeker')
INSERT [dbo].[roles] ([id], [name], [description]) VALUES (3, N'Employer', N'Company representative')
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
SET IDENTITY_INSERT [dbo].[skills] ON 

INSERT [dbo].[skills] ([id], [name]) VALUES (1, N'JavaScript')
INSERT [dbo].[skills] ([id], [name]) VALUES (2, N'Python')
INSERT [dbo].[skills] ([id], [name]) VALUES (3, N'SQL')
SET IDENTITY_INSERT [dbo].[skills] OFF
GO
SET IDENTITY_INSERT [dbo].[system_feedback] ON 

INSERT [dbo].[system_feedback] ([id], [user_id], [feedback_text], [created_at]) VALUES (1, 2, N'Great platform!', CAST(N'2025-06-10T14:23:28.517' AS DateTime))
SET IDENTITY_INSERT [dbo].[system_feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[system_logs] ON 

INSERT [dbo].[system_logs] ([id], [user_id], [action], [description], [created_at]) VALUES (1, 2, N'Login', N'User logged in', CAST(N'2025-06-10T14:23:33.503' AS DateTime))
SET IDENTITY_INSERT [dbo].[system_logs] OFF
GO
SET IDENTITY_INSERT [dbo].[user_notifications] ON 

INSERT [dbo].[user_notifications] ([id], [user_id], [title], [message], [is_read], [created_at]) VALUES (1, 2, N'Application Received', N'Your application has been received.', 0, CAST(N'2025-06-10T14:23:20.483' AS DateTime))
SET IDENTITY_INSERT [dbo].[user_notifications] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [role_id], [email], [phone], [password_hash], [full_name], [is_email_verified], [is_phone_verified], [avatar_url], [status], [created_at], [updated_at]) VALUES (1, 1, N'admin@example.com', N'1234567890', N'hashed_password_admin', N'Admin User', 1, 0, NULL, N'active', CAST(N'2025-06-10T14:22:22.933' AS DateTime), CAST(N'2025-06-10T14:22:22.933' AS DateTime))
INSERT [dbo].[users] ([id], [role_id], [email], [phone], [password_hash], [full_name], [is_email_verified], [is_phone_verified], [avatar_url], [status], [created_at], [updated_at]) VALUES (2, 2, N'candidate@example.com', N'0987654321', N'hashed_password_candidate', N'John Doe', 1, 0, NULL, N'active', CAST(N'2025-06-10T14:22:22.933' AS DateTime), CAST(N'2025-06-10T14:22:22.933' AS DateTime))
INSERT [dbo].[users] ([id], [role_id], [email], [phone], [password_hash], [full_name], [is_email_verified], [is_phone_verified], [avatar_url], [status], [created_at], [updated_at]) VALUES (3, 3, N'employer@example.com', N'0123456789', N'hashed_password_employer', N'Acme Corp HR', 1, 0, NULL, N'active', CAST(N'2025-06-10T14:22:22.933' AS DateTime), CAST(N'2025-06-10T14:22:22.933' AS DateTime))
INSERT [dbo].[users] ([id], [role_id], [email], [phone], [password_hash], [full_name], [is_email_verified], [is_phone_verified], [avatar_url], [status], [created_at], [updated_at]) VALUES (4, 2, N'21@gg', N'', N'$2a$10$8yIL5hwrRbNLQis.2hYVP.m.D8sSGMh30zYLtWHxiqO7ZqMGx2JjS', N'12', 0, 0, NULL, N'active', CAST(N'2025-06-12T22:14:53.347' AS DateTime), CAST(N'2025-06-12T22:14:53.347' AS DateTime))
INSERT [dbo].[users] ([id], [role_id], [email], [phone], [password_hash], [full_name], [is_email_verified], [is_phone_verified], [avatar_url], [status], [created_at], [updated_at]) VALUES (5, 1, N'21@gg2', N'', N'$2a$10$66inarHKlFDMuVN3lbbaVenCcl8Kze03vBEc4o7xqWJoREFFku/Te', N'12', 0, 0, NULL, N'active', CAST(N'2025-06-12T22:19:15.767' AS DateTime), CAST(N'2025-06-12T22:19:15.767' AS DateTime))
INSERT [dbo].[users] ([id], [role_id], [email], [phone], [password_hash], [full_name], [is_email_verified], [is_phone_verified], [avatar_url], [status], [created_at], [updated_at]) VALUES (6, 2, N'quanda@ngu', N'', N'$2a$10$G4l8hIROj59DahP1evbIi.eSJlqmhlUYaS4atTQ6k81D646Up3kQ6', N'12', 0, 0, NULL, N'active', CAST(N'2025-06-12T22:25:02.640' AS DateTime), CAST(N'2025-06-12T22:25:02.640' AS DateTime))
INSERT [dbo].[users] ([id], [role_id], [email], [phone], [password_hash], [full_name], [is_email_verified], [is_phone_verified], [avatar_url], [status], [created_at], [updated_at]) VALUES (7, 3, N'quanhai1@gmail.com', N'', N'$2a$10$bYHPS3nsPclDjWe8/j7U6ufTOhfHrfBw0dbO6fZhKWQy6wZMGXw3G', N'quanhai', 0, 0, NULL, N'active', CAST(N'2025-06-12T22:29:16.160' AS DateTime), CAST(N'2025-06-12T22:29:16.160' AS DateTime))
INSERT [dbo].[users] ([id], [role_id], [email], [phone], [password_hash], [full_name], [is_email_verified], [is_phone_verified], [avatar_url], [status], [created_at], [updated_at]) VALUES (8, 2, N'x', N'', N'$2a$10$YTi9jU/T6JkkxtHTLK.iSetbfz6NAMMwBcYvhoxGnst8RiYx5RuzO', N'abc', 0, 0, NULL, N'active', CAST(N'2025-06-12T22:39:53.790' AS DateTime), CAST(N'2025-06-12T22:39:53.790' AS DateTime))
INSERT [dbo].[users] ([id], [role_id], [email], [phone], [password_hash], [full_name], [is_email_verified], [is_phone_verified], [avatar_url], [status], [created_at], [updated_at]) VALUES (9, 2, N'bc@gmail.com', N'', N'$2a$10$8oPew9RIJ97n5gCpLkJQQOfMlgNIeZPzaooIoDdkddqkSWdRYWwZO', N'bc', 0, 0, NULL, N'active', CAST(N'2025-06-13T07:05:10.340' AS DateTime), CAST(N'2025-06-13T07:05:10.340' AS DateTime))
INSERT [dbo].[users] ([id], [role_id], [email], [phone], [password_hash], [full_name], [is_email_verified], [is_phone_verified], [avatar_url], [status], [created_at], [updated_at]) VALUES (10, 2, N'bcd@gmail.com', N'', N'$2a$10$HESDDlxSYEPF0oA9Jnj4Jea2UkDp7rdsGnfbqS5pJpSJzKNxMX346', N'bcd', 0, 0, NULL, N'active', CAST(N'2025-06-13T16:58:36.987' AS DateTime), CAST(N'2025-06-13T16:58:36.987' AS DateTime))
INSERT [dbo].[users] ([id], [role_id], [email], [phone], [password_hash], [full_name], [is_email_verified], [is_phone_verified], [avatar_url], [status], [created_at], [updated_at]) VALUES (11, 3, N'abcde@gmail.com', N'', N'$2a$10$iY2cmzVhFS9NbyKhvkiUhOFKAEHJqQGGVMp5Rmkby67QkGLadkQsm', N'aaas', 0, 0, NULL, N'active', CAST(N'2025-06-13T20:41:44.213' AS DateTime), CAST(N'2025-06-13T20:41:44.213' AS DateTime))
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET IDENTITY_INSERT [dbo].[work_experiences] ON 

INSERT [dbo].[work_experiences] ([id], [candidate_cv_id], [job_title], [company_name], [start_date], [end_date], [description], [achievements]) VALUES (1, 1, N'Web Developer', N'ABC Corp', CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), N'Developed web applications', N'Improved performance by 30%')
SET IDENTITY_INSERT [dbo].[work_experiences] OFF
GO
SET IDENTITY_INSERT [dbo].[audit_logs] ON

INSERT [dbo].[audit_logs] ([id], [user_id], [action_type], [entity_type], [entity_id], [old_value], [new_value], [ip_address], [timestamp], [severity]) VALUES (12, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '192.168.1.100', CAST(N'2025-06-14T09:15:22.000' AS DateTime), 'INFO')

INSERT [dbo].[audit_logs] ([id], [user_id], [action_type], [entity_type], [entity_id], [old_value], [new_value], [ip_address], [timestamp], [severity]) VALUES (13, NULL, 'SYSTEM_WARNING', 'system', 0, NULL, '{"message":"Disk space low"}', '127.0.0.1', CAST(N'2025-06-14T09:20:35.000' AS DateTime), 'WARNING')

INSERT [dbo].[audit_logs] ([id], [user_id], [action_type], [entity_type], [entity_id], [old_value], [new_value], [ip_address], [timestamp], [severity]) VALUES (14, 2, 'PROFILE_UPDATE', 'candidate_profiles', 2, '{"headline":"Developer"}', '{"headline":"Senior Developer"}', '10.0.0.15', CAST(N'2025-06-14T09:25:47.000' AS DateTime), 'CRITICAL')

INSERT [dbo].[audit_logs] ([id], [user_id], [action_type], [entity_type], [entity_id], [old_value], [new_value], [ip_address], [timestamp], [severity]) VALUES (15, 3, 'JOB_CREATE', 'job_postings', 5, NULL, '{"title":"Backend Engineer"}', '172.16.0.22', CAST(N'2025-06-14T09:30:12.000' AS DateTime), 'INFO')

SET IDENTITY_INSERT [dbo].[audit_logs] OFF





/****** Object:  Index [UQ__candidat__B9BE370E2361BC7F]    Script Date: 6/13/2025 9:04:16 PM ******/
ALTER TABLE [dbo].[candidate_profiles] ADD UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__company___B9BE370ECD8AD42D]    Script Date: 6/13/2025 9:04:16 PM ******/
ALTER TABLE [dbo].[company_profiles] ADD UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__permissi__72E12F1BCD3E5589]    Script Date: 6/13/2025 9:04:16 PM ******/
ALTER TABLE [dbo].[permissions] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__roles__72E12F1B5983BD44]    Script Date: 6/13/2025 9:04:16 PM ******/
ALTER TABLE [dbo].[roles] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__skills__72E12F1BDFD27332]    Script Date: 6/13/2025 9:04:16 PM ******/
ALTER TABLE [dbo].[skills] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E6164D3855612]    Script Date: 6/13/2025 9:04:16 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[applications] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[applications] ADD  DEFAULT (getdate()) FOR [applied_at]
GO
ALTER TABLE [dbo].[applications] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[audit_logs] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[bookmarks] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[candidate_cvs] ADD  DEFAULT ((0)) FOR [is_default]
GO
ALTER TABLE [dbo].[candidate_cvs] ADD  DEFAULT (getdate()) FOR [uploaded_at]
GO
ALTER TABLE [dbo].[candidate_profiles] ADD  DEFAULT ((0)) FOR [experience_years]
GO
ALTER TABLE [dbo].[candidate_profiles] ADD  DEFAULT ((1)) FOR [is_searchable]
GO
ALTER TABLE [dbo].[candidate_profiles] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[candidate_profiles] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[company_profiles] ADD  DEFAULT ((0)) FOR [is_featured]
GO
ALTER TABLE [dbo].[company_profiles] ADD  DEFAULT ((1)) FOR [is_searchable]
GO
ALTER TABLE [dbo].[company_profiles] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[company_profiles] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[company_reviews] ADD  DEFAULT (getdate()) FOR [reviewed_at]
GO
ALTER TABLE [dbo].[connections] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[connections] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[featured_companies] ADD  DEFAULT (getdate()) FOR [featured_since]
GO
ALTER TABLE [dbo].[group_members] ADD  DEFAULT (getdate()) FOR [joined_at]
GO
ALTER TABLE [dbo].[groups] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[interviews] ADD  DEFAULT ('scheduled') FOR [status]
GO
ALTER TABLE [dbo].[interviews] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[interviews] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[job_postings] ADD  DEFAULT ('open') FOR [status]
GO
ALTER TABLE [dbo].[job_postings] ADD  DEFAULT (getdate()) FOR [posted_at]
GO
ALTER TABLE [dbo].[job_recommendations] ADD  DEFAULT (getdate()) FOR [recommended_at]
GO
ALTER TABLE [dbo].[login_history] ADD  DEFAULT (getdate()) FOR [login_time]
GO
ALTER TABLE [dbo].[messages] ADD  DEFAULT (getdate()) FOR [sent_at]
GO
ALTER TABLE [dbo].[messages] ADD  DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[otp_verifications] ADD  DEFAULT ((0)) FOR [attempts]
GO
ALTER TABLE [dbo].[otp_verifications] ADD  DEFAULT ((0)) FOR [is_used]
GO
ALTER TABLE [dbo].[otp_verifications] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[support_tickets] ADD  DEFAULT ('open') FOR [status]
GO
ALTER TABLE [dbo].[support_tickets] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[support_tickets] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[system_feedback] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[system_logs] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[user_follows] ADD  DEFAULT (getdate()) FOR [followed_at]
GO
ALTER TABLE [dbo].[user_notifications] ADD  DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[user_notifications] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [is_email_verified]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [is_phone_verified]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[applications]  WITH CHECK ADD FOREIGN KEY([candidate_profile_id])
REFERENCES [dbo].[candidate_profiles] ([id])
GO
ALTER TABLE [dbo].[applications]  WITH CHECK ADD FOREIGN KEY([candidate_cv_id])
REFERENCES [dbo].[candidate_cvs] ([id])
GO
ALTER TABLE [dbo].[applications]  WITH CHECK ADD FOREIGN KEY([job_posting_id])
REFERENCES [dbo].[job_postings] ([id])
GO
ALTER TABLE [dbo].[audit_logs]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[bookmarks]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[candidate_cvs]  WITH CHECK ADD FOREIGN KEY([candidate_profile_id])
REFERENCES [dbo].[candidate_profiles] ([id])
GO
ALTER TABLE [dbo].[candidate_profiles]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[candidate_skills]  WITH CHECK ADD FOREIGN KEY([candidate_cv_id])
REFERENCES [dbo].[candidate_cvs] ([id])
GO
ALTER TABLE [dbo].[candidate_skills]  WITH CHECK ADD FOREIGN KEY([skill_id])
REFERENCES [dbo].[skills] ([id])
GO
ALTER TABLE [dbo].[certifications]  WITH CHECK ADD FOREIGN KEY([candidate_cv_id])
REFERENCES [dbo].[candidate_cvs] ([id])
GO
ALTER TABLE [dbo].[company_industries]  WITH CHECK ADD FOREIGN KEY([company_profile_id])
REFERENCES [dbo].[company_profiles] ([id])
GO
ALTER TABLE [dbo].[company_industries]  WITH CHECK ADD FOREIGN KEY([industry_id])
REFERENCES [dbo].[industries] ([id])
GO
ALTER TABLE [dbo].[company_profiles]  WITH CHECK ADD FOREIGN KEY([industry_id])
REFERENCES [dbo].[industries] ([id])
GO
ALTER TABLE [dbo].[company_profiles]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[company_reviews]  WITH CHECK ADD FOREIGN KEY([candidate_profile_id])
REFERENCES [dbo].[candidate_profiles] ([id])
GO
ALTER TABLE [dbo].[company_reviews]  WITH CHECK ADD FOREIGN KEY([company_profile_id])
REFERENCES [dbo].[company_profiles] ([id])
GO
ALTER TABLE [dbo].[connections]  WITH CHECK ADD FOREIGN KEY([connected_user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[connections]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[content]  WITH CHECK ADD FOREIGN KEY([author_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[education_details]  WITH CHECK ADD FOREIGN KEY([candidate_cv_id])
REFERENCES [dbo].[candidate_cvs] ([id])
GO
ALTER TABLE [dbo].[featured_companies]  WITH CHECK ADD FOREIGN KEY([company_profile_id])
REFERENCES [dbo].[company_profiles] ([id])
GO
ALTER TABLE [dbo].[group_members]  WITH CHECK ADD FOREIGN KEY([group_id])
REFERENCES [dbo].[groups] ([id])
GO
ALTER TABLE [dbo].[group_members]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[groups]  WITH CHECK ADD FOREIGN KEY([created_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[interviews]  WITH CHECK ADD FOREIGN KEY([application_id])
REFERENCES [dbo].[applications] ([id])
GO
ALTER TABLE [dbo].[job_posting_categories]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[categories] ([id])
GO
ALTER TABLE [dbo].[job_posting_categories]  WITH CHECK ADD FOREIGN KEY([job_posting_id])
REFERENCES [dbo].[job_postings] ([id])
GO
ALTER TABLE [dbo].[job_postings]  WITH CHECK ADD FOREIGN KEY([company_profile_id])
REFERENCES [dbo].[company_profiles] ([id])
GO
ALTER TABLE [dbo].[job_recommendations]  WITH CHECK ADD FOREIGN KEY([candidate_profile_id])
REFERENCES [dbo].[candidate_profiles] ([id])
GO
ALTER TABLE [dbo].[job_recommendations]  WITH CHECK ADD FOREIGN KEY([job_posting_id])
REFERENCES [dbo].[job_postings] ([id])
GO
ALTER TABLE [dbo].[job_required_skills]  WITH CHECK ADD FOREIGN KEY([job_posting_id])
REFERENCES [dbo].[job_postings] ([id])
GO
ALTER TABLE [dbo].[job_required_skills]  WITH CHECK ADD FOREIGN KEY([skill_id])
REFERENCES [dbo].[skills] ([id])
GO
ALTER TABLE [dbo].[login_history]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD FOREIGN KEY([receiver_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD FOREIGN KEY([sender_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[otp_verifications]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[role_permissions]  WITH CHECK ADD FOREIGN KEY([permission_id])
REFERENCES [dbo].[permissions] ([id])
GO
ALTER TABLE [dbo].[role_permissions]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[support_tickets]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[system_feedback]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[system_logs]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[user_follows]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[user_notifications]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[work_experiences]  WITH CHECK ADD FOREIGN KEY([candidate_cv_id])
REFERENCES [dbo].[candidate_cvs] ([id])
GO
USE [master]
GO
ALTER DATABASE [TechSignDB] SET  READ_WRITE 
GO



