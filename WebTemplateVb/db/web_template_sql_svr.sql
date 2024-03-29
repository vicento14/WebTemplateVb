USE [master]
GO
/****** Object:  Database [web_template]    Script Date: 2023/10/26 2:52:20 pm ******/
CREATE DATABASE [web_template]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'web_template', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\web_template.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'web_template_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\web_template_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [web_template] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [web_template].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [web_template] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [web_template] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [web_template] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [web_template] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [web_template] SET ARITHABORT OFF 
GO
ALTER DATABASE [web_template] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [web_template] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [web_template] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [web_template] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [web_template] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [web_template] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [web_template] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [web_template] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [web_template] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [web_template] SET  DISABLE_BROKER 
GO
ALTER DATABASE [web_template] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [web_template] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [web_template] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [web_template] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [web_template] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [web_template] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [web_template] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [web_template] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [web_template] SET  MULTI_USER 
GO
ALTER DATABASE [web_template] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [web_template] SET DB_CHAINING OFF 
GO
ALTER DATABASE [web_template] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [web_template] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [web_template] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [web_template] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [web_template] SET QUERY_STORE = OFF
GO
USE [web_template]
GO
/****** Object:  Table [dbo].[t_exercise]    Script Date: 2023/10/26 2:52:20 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_exercise](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[details] [varchar](255) NOT NULL,
	[date_updated] [datetime] NOT NULL,
 CONSTRAINT [PK_t_exercise] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_t1]    Script Date: 2023/10/26 2:52:20 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_t1](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[c1] [varchar](255) NOT NULL,
	[c2] [varchar](255) NOT NULL,
	[c3] [varchar](255) NOT NULL,
	[c4] [varchar](255) NOT NULL,
	[date_updated] [datetime] NOT NULL,
 CONSTRAINT [PK_t_t1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_t2]    Script Date: 2023/10/26 2:52:20 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_t2](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[c1] [varchar](255) NOT NULL,
	[d1] [nchar](10) NOT NULL,
	[d2] [nchar](10) NOT NULL,
	[d3] [nchar](10) NOT NULL,
	[date_updated] [datetime] NOT NULL,
 CONSTRAINT [PK_t_t2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_accounts]    Script Date: 2023/10/26 2:52:20 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_accounts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_number] [varchar](20) NULL,
	[full_name] [varchar](50) NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[section] [varchar](50) NULL,
	[role] [varchar](20) NULL,
 CONSTRAINT [PK_user_account] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[t_exercise] ON 

INSERT [dbo].[t_exercise] ([id], [name], [details], [date_updated]) VALUES (2, N'HTML', N'This markup tells a web browser how to display text, images and other forms of multimedia on a webpage.', CAST(N'2023-10-25T10:48:29.850' AS DateTime))
INSERT [dbo].[t_exercise] ([id], [name], [details], [date_updated]) VALUES (3, N'CSS', N'CSS is the acronym of “Cascading Style Sheets”. CSS is a computer language for laying out and structuring web pages (HTML or XML).', CAST(N'2023-10-25T10:48:42.170' AS DateTime))
INSERT [dbo].[t_exercise] ([id], [name], [details], [date_updated]) VALUES (4, N'JavaScript', N'It allows you to implement dynamic features on web pages that cannot be done with only HTML and CSS.', CAST(N'2023-10-25T10:48:58.193' AS DateTime))
INSERT [dbo].[t_exercise] ([id], [name], [details], [date_updated]) VALUES (5, N'PHP', N'widely-used open source general-purpose scripting language that is especially suited for web.', CAST(N'2023-10-25T10:49:12.190' AS DateTime))
INSERT [dbo].[t_exercise] ([id], [name], [details], [date_updated]) VALUES (6, N'SQL', N'a standard language for database creation and manipulation.', CAST(N'2023-10-25T10:49:25.193' AS DateTime))
SET IDENTITY_INSERT [dbo].[t_exercise] OFF
GO
SET IDENTITY_INSERT [dbo].[t_t1] ON 

INSERT [dbo].[t_t1] ([id], [c1], [c2], [c3], [c4], [date_updated]) VALUES (2, N'r1', N'abc', N'def', N'ghi', CAST(N'2023-10-25T10:44:42.573' AS DateTime))
INSERT [dbo].[t_t1] ([id], [c1], [c2], [c3], [c4], [date_updated]) VALUES (3, N'r2', N'jkl', N'mno', N'pqr', CAST(N'2023-10-25T10:45:19.800' AS DateTime))
INSERT [dbo].[t_t1] ([id], [c1], [c2], [c3], [c4], [date_updated]) VALUES (4, N'r3', N'stu', N'vwx', N'yz1', CAST(N'2023-10-25T10:45:36.803' AS DateTime))
INSERT [dbo].[t_t1] ([id], [c1], [c2], [c3], [c4], [date_updated]) VALUES (5, N'r4', N'234', N'567', N'890', CAST(N'2023-10-25T10:46:00.037' AS DateTime))
SET IDENTITY_INSERT [dbo].[t_t1] OFF
GO
SET IDENTITY_INSERT [dbo].[t_t2] ON 

INSERT [dbo].[t_t2] ([id], [c1], [d1], [d2], [d3], [date_updated]) VALUES (1, N'r1', N'abc       ', N'def       ', N'ghi       ', CAST(N'2023-10-25T10:46:43.603' AS DateTime))
INSERT [dbo].[t_t2] ([id], [c1], [d1], [d2], [d3], [date_updated]) VALUES (2, N'r1', N'jkl       ', N'mno       ', N'pqr       ', CAST(N'2023-10-25T10:47:01.083' AS DateTime))
INSERT [dbo].[t_t2] ([id], [c1], [d1], [d2], [d3], [date_updated]) VALUES (3, N'r1', N'stu       ', N'vwx       ', N'yz1       ', CAST(N'2023-10-25T10:47:17.600' AS DateTime))
INSERT [dbo].[t_t2] ([id], [c1], [d1], [d2], [d3], [date_updated]) VALUES (4, N'r4', N'234       ', N'567       ', N'890       ', CAST(N'2023-10-25T10:47:33.113' AS DateTime))
SET IDENTITY_INSERT [dbo].[t_t2] OFF
GO
SET IDENTITY_INSERT [dbo].[user_accounts] ON 

INSERT [dbo].[user_accounts] ([id], [id_number], [full_name], [username], [password], [section], [role]) VALUES (2, N'22-08675', N'Alcantara, Vince Dale D.', N'vince', N'22-08675', N'IT', N'admin')
INSERT [dbo].[user_accounts] ([id], [id_number], [full_name], [username], [password], [section], [role]) VALUES (3, N'N/A', N'TEST', N'TEST', N'TEST', N'IT', N'user')
INSERT [dbo].[user_accounts] ([id], [id_number], [full_name], [username], [password], [section], [role]) VALUES (4, N'N/A', N'TESTING101', N'TESTING101', N'TESTING101', N'IT', N'user')
INSERT [dbo].[user_accounts] ([id], [id_number], [full_name], [username], [password], [section], [role]) VALUES (5, N'23-12345', N'abcdefg', N'abcdefg', N'abcdefg', N'IT', N'user')
INSERT [dbo].[user_accounts] ([id], [id_number], [full_name], [username], [password], [section], [role]) VALUES (6, N'23-67890', N'hijklmnop', N'hijklmnop', N'hijklmnop', N'IT', N'user')
INSERT [dbo].[user_accounts] ([id], [id_number], [full_name], [username], [password], [section], [role]) VALUES (7, N'23-13579', N'qrstuv', N'qrstuv', N'qrstuv', N'IT', N'user')
INSERT [dbo].[user_accounts] ([id], [id_number], [full_name], [username], [password], [section], [role]) VALUES (8, N'23-02468', N'wxyz', N'wxyz', N'wxyz', N'IT', N'user')
INSERT [dbo].[user_accounts] ([id], [id_number], [full_name], [username], [password], [section], [role]) VALUES (9, N'N/A', N'TESTA', N'TESTA', N'TESTA', N'IT', N'user')
INSERT [dbo].[user_accounts] ([id], [id_number], [full_name], [username], [password], [section], [role]) VALUES (10, N'N/A', N'''TESTING''', N'''TESTING''', N'''TESTING''', N'IT', N'user')
SET IDENTITY_INSERT [dbo].[user_accounts] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_Table_1]    Script Date: 2023/10/26 2:52:20 pm ******/
ALTER TABLE [dbo].[t_exercise] ADD  CONSTRAINT [UX_Table_1] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_Table1]    Script Date: 2023/10/26 2:52:20 pm ******/
ALTER TABLE [dbo].[t_t1] ADD  CONSTRAINT [UX_Table1] UNIQUE NONCLUSTERED 
(
	[c1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_t_t2]    Script Date: 2023/10/26 2:52:20 pm ******/
CREATE NONCLUSTERED INDEX [IX_t_t2] ON [dbo].[t_t2]
(
	[c1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_exercise] ADD  CONSTRAINT [DF_t_exercise_date_updated]  DEFAULT (getdate()) FOR [date_updated]
GO
ALTER TABLE [dbo].[t_t1] ADD  CONSTRAINT [DF_t_t1_date_updated]  DEFAULT (getdate()) FOR [date_updated]
GO
ALTER TABLE [dbo].[t_t2] ADD  CONSTRAINT [DF_t_t2_date_updated]  DEFAULT (getdate()) FOR [date_updated]
GO
USE [master]
GO
ALTER DATABASE [web_template] SET  READ_WRITE 
GO
