USE [master]
GO
/****** Object:  Database [LiteCommerceDB]    Script Date: 9/10/2024 5:16:46 PM ******/
CREATE DATABASE [LiteCommerceDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LiteCommerceDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SA\MSSQL\DATA\LiteCommerceDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LiteCommerceDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SA\MSSQL\DATA\LiteCommerceDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [LiteCommerceDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LiteCommerceDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LiteCommerceDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LiteCommerceDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LiteCommerceDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LiteCommerceDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LiteCommerceDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LiteCommerceDB] SET  MULTI_USER 
GO
ALTER DATABASE [LiteCommerceDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LiteCommerceDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LiteCommerceDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LiteCommerceDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LiteCommerceDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LiteCommerceDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [LiteCommerceDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [LiteCommerceDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [LiteCommerceDB]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK__Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](255) NOT NULL,
	[ContactName] [nvarchar](255) NOT NULL,
	[Province] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[IsLocked] [bit] NULL,
 CONSTRAINT [PK__Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_Customers_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[BirthDate] [date] NULL,
	[Address] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Photo] [nvarchar](255) NULL,
	[IsWorking] [bit] NULL,
	[RoleNames] [nvarchar](100) NULL,
 CONSTRAINT [PK__Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_Employees_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[SalePrice] [money] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[OrderTime] [datetime] NOT NULL,
	[DeliveryProvince] [nvarchar](255) NULL,
	[DeliveryAddress] [nvarchar](255) NULL,
	[EmployeeID] [int] NULL,
	[AcceptTime] [datetime] NULL,
	[ShipperID] [int] NULL,
	[ShippedTime] [datetime] NULL,
	[FinishedTime] [datetime] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK__Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[Status] [int] NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductAttributes]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAttributes](
	[AttributeID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[AttributeName] [nvarchar](255) NOT NULL,
	[AttributeValue] [nvarchar](max) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
 CONSTRAINT [PK_ProductAttributes] PRIMARY KEY CLUSTERED 
(
	[AttributeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductPhotos]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductPhotos](
	[PhotoID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Photo] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsHidden] [bit] NOT NULL,
 CONSTRAINT [PK_ProductPhotos] PRIMARY KEY CLUSTERED 
(
	[PhotoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](255) NOT NULL,
	[ProductDescription] [nvarchar](2000) NULL,
	[SupplierID] [int] NULL,
	[CategoryID] [int] NULL,
	[Unit] [nvarchar](255) NOT NULL,
	[Price] [money] NOT NULL,
	[Photo] [nvarchar](255) NULL,
	[IsSelling] [bit] NULL,
 CONSTRAINT [PK__Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provinces]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provinces](
	[ProvinceName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Provinces] PRIMARY KEY CLUSTERED 
(
	[ProvinceName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shippers]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shippers](
	[ShipperID] [int] IDENTITY(1,1) NOT NULL,
	[ShipperName] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](255) NULL,
 CONSTRAINT [PK__Shippers] PRIMARY KEY CLUSTERED 
(
	[ShipperID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 9/10/2024 5:16:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] [nvarchar](255) NOT NULL,
	[ContactName] [nvarchar](255) NOT NULL,
	[Provice] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[Logo] [nvarchar](255) NULL,
 CONSTRAINT [PK__Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categories] ADD  CONSTRAINT [DF__Categorie__Categ__35BCFE0A]  DEFAULT (NULL) FOR [CategoryName]
GO
ALTER TABLE [dbo].[Categories] ADD  CONSTRAINT [DF__Categorie__Descr__36B12243]  DEFAULT (NULL) FOR [Description]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF__Customers__Custo__38996AB5]  DEFAULT (NULL) FOR [CustomerName]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF__Customers__Conta__398D8EEE]  DEFAULT (NULL) FOR [ContactName]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF__Customers__Addre__3A81B327]  DEFAULT (NULL) FOR [Address]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF__Customers__City__3B75D760]  DEFAULT (NULL) FOR [Phone]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF__Employees__LastN__3F466844]  DEFAULT (NULL) FOR [FullName]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF__Employees__Birth__412EB0B6]  DEFAULT (NULL) FOR [BirthDate]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF__Employees__Photo__4222D4EF]  DEFAULT (NULL) FOR [Address]
GO
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF__OrderDeta__Quant__48CFD27E]  DEFAULT (NULL) FOR [Quantity]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF__Orders__Customer__440B1D61]  DEFAULT (NULL) FOR [CustomerID]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF__Orders__OrderDat__45F365D3]  DEFAULT (NULL) FOR [OrderTime]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF__Orders__Employee__44FF419A]  DEFAULT (NULL) FOR [EmployeeID]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF__Orders__ShipperI__46E78A0C]  DEFAULT (NULL) FOR [ShipperID]
GO
ALTER TABLE [dbo].[ProductPhotos] ADD  CONSTRAINT [DF_ProductGallery_IsHidden]  DEFAULT ((0)) FOR [IsHidden]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF__Products__Produc__4AB81AF0]  DEFAULT (NULL) FOR [ProductName]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF__Products__Suppli__4BAC3F29]  DEFAULT (NULL) FOR [SupplierID]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF__Products__Catego__4CA06362]  DEFAULT (NULL) FOR [CategoryID]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF__Products__Unit__4D94879B]  DEFAULT (NULL) FOR [Unit]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF__Products__Price__4E88ABD4]  DEFAULT (NULL) FOR [Price]
GO
ALTER TABLE [dbo].[Shippers] ADD  CONSTRAINT [DF__Shippers__Shippe__619B8048]  DEFAULT (NULL) FOR [ShipperName]
GO
ALTER TABLE [dbo].[Shippers] ADD  CONSTRAINT [DF__Shippers__Phone__628FA481]  DEFAULT (NULL) FOR [Phone]
GO
ALTER TABLE [dbo].[Suppliers] ADD  CONSTRAINT [DF__Suppliers__Suppl__6477ECF3]  DEFAULT (NULL) FOR [SupplierName]
GO
ALTER TABLE [dbo].[Suppliers] ADD  CONSTRAINT [DF__Suppliers__Conta__656C112C]  DEFAULT (NULL) FOR [ContactName]
GO
ALTER TABLE [dbo].[Suppliers] ADD  CONSTRAINT [DF__Suppliers__Addre__66603565]  DEFAULT (NULL) FOR [Address]
GO
ALTER TABLE [dbo].[Suppliers] ADD  CONSTRAINT [DF__Suppliers__Phone__6A30C649]  DEFAULT (NULL) FOR [Phone]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Provinces] FOREIGN KEY([Province])
REFERENCES [dbo].[Provinces] ([ProvinceName])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Provinces]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_OrderStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[OrderStatus] ([Status])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_OrderStatus]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Shippers] FOREIGN KEY([ShipperID])
REFERENCES [dbo].[Shippers] ([ShipperID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Shippers]
GO
ALTER TABLE [dbo].[ProductAttributes]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributes_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductAttributes] CHECK CONSTRAINT [FK_ProductAttributes_Products]
GO
ALTER TABLE [dbo].[ProductPhotos]  WITH CHECK ADD  CONSTRAINT [FK_ProductGallery_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductPhotos] CHECK CONSTRAINT [FK_ProductGallery_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
ALTER TABLE [dbo].[Suppliers]  WITH CHECK ADD  CONSTRAINT [FK_Suppliers_Provinces] FOREIGN KEY([Provice])
REFERENCES [dbo].[Provinces] ([ProvinceName])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Suppliers] CHECK CONSTRAINT [FK_Suppliers_Provinces]
GO
USE [master]
GO
ALTER DATABASE [LiteCommerceDB] SET  READ_WRITE 
GO
