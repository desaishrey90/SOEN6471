/*
* LinqCommerce - Standalone and Sitefinity ready asp.net eCommerce 
* Creation Script for Tables and Stored Procedures
* Version: 3.2
*/

--Tables
--lc_Department
CREATE TABLE [dbo].[lc_Department](
	DepartmentID INT IDENTITY(1,1) NOT NULL,
	Name VARCHAR(50) NOT NULL,
	Description VARCHAR(1000) NULL,
 CONSTRAINT PK_Department PRIMARY KEY CLUSTERED (DepartmentID ASC)
)
GO

--lc_Category
CREATE TABLE [dbo].[lc_Category](
	CategoryID INT IDENTITY(1,1) NOT NULL,
	DepartmentID INT NOT NULL,
	Name VARCHAR(50) NOT NULL,
	Description VARCHAR(1000) NULL,
 CONSTRAINT PK_Category_1 PRIMARY KEY CLUSTERED(CategoryID ASC)
)
GO

--lc_Orders
CREATE TABLE [dbo].[lc_Orders](
	OrderID INT IDENTITY(1,1) NOT NULL,
	DateCreated SMALLDATETIME NOT NULL CONSTRAINT DF_Orders_DateCreated  DEFAULT (getdate()),
	DateShipped SMALLDATETIME NULL,
	Verified BIT NOT NULL CONSTRAINT DF_Orders_Verified DEFAULT ((0)),
	Completed BIT NOT NULL CONSTRAINT DF_Orders_Completed DEFAULT ((0)),
	Canceled BIT NOT NULL CONSTRAINT DF_Orders_Canceled DEFAULT ((0)),
	Comments VARCHAR(1000) NULL,
	CustomerName VARCHAR(50) NULL,
	CustomerEmail VARCHAR(50) NULL,
	ShippingAddress VARCHAR(500) NULL,
 CONSTRAINT PK_Orders PRIMARY KEY CLUSTERED(OrderID ASC)
)
GO

--lc_OrderDetail
CREATE TABLE [dbo].[lc_OrderDetail](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[Subtotal]  AS ([Quantity]*[UnitCost]),
	[Size] [nvarchar](50) NULL,
	[Color] [nvarchar](50) NULL,
	[CouponCode] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[SellerID] [int] NULL,
	[Tax] [float] NULL,
	[Region] [nvarchar](50) NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[lc_OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[lc_Orders] ([OrderID])
GO
ALTER TABLE [dbo].[lc_OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Orders]
GO

--lc_Product
CREATE TABLE [dbo].[lc_Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [varchar](5000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Price] [money] NOT NULL,
	[Image1FileName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Image2FileName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OnCatalogPromotion] [bit] NOT NULL,
	[OnDepartmentPromotion] [bit] NOT NULL,
	[Sizeable] [bit] NOT NULL,
	[Colorable] [bit] NOT NULL,
	[DateAdded] [smalldatetime] NOT NULL CONSTRAINT [DF_Product_DateAdded]  DEFAULT (getdate()),
	[TotalRemaining] [int] NOT NULL CONSTRAINT [DF_Product_TotalRemaining]  DEFAULT ((0)),
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

--lc_ProductCategory
CREATE TABLE [dbo].[lc_ProductCategory](
	ProductID INT NOT NULL,
	CategoryID INT NOT NULL,
 CONSTRAINT PK_ProductCategory PRIMARY KEY CLUSTERED (ProductID ASC, CategoryID ASC)
) 
GO

--lc_SizeTable
CREATE TABLE [dbo].[lc_SizeTable](
SizeID INT IDENTITY(1,1) NOT NULL,
Size nvarchar(50) NOT NULL,
CONSTRAINT PK_SizeTable PRIMARY KEY CLUSTERED (SizeID ASC)
)
GO
Insert into lc_SizeTable(Size)
Values
('None')
GO
Insert into lc_SizeTable(Size)
Values
('Small')

GO

Insert into lc_SizeTable(Size)
Values
('Medium')

GO

--lc_ColorTable
CREATE TABLE [dbo].[lc_ColorTable](
ColorID INT IDENTITY(1,1)  NOT NULL,
Color nvarchar(50) NOT NULL,
CONSTRAINT PK_ColorTable PRIMARY KEY CLUSTERED (ColorID ASC)
)
GO
Insert into lc_ColorTable(Color)
Values
('None')

GO
Insert into lc_ColorTable(Color)
Values
('Red')

Go
Insert into lc_ColorTable(Color)
Values
('Blue')
Go
Insert into lc_ColorTable(Color)
Values
('Black')


GO
--lc_ShoppingCart
GO
CREATE TABLE [dbo].[lc_ShoppingCart](
	[CartID] [char](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[DateAdded] [smalldatetime] NOT NULL,
	[SizeID] [int] NOT NULL,
	[ColorID] [int] NOT NULL,
	[Price] [money] NOT NULL,
 CONSTRAINT [PK_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[CartID] ASC,
	[ProductID] ASC,
	[SizeID] ASC,
	[ColorID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[lc_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_ColorTable] FOREIGN KEY([ColorID])
REFERENCES [dbo].[lc_ColorTable] ([ColorID])
GO
ALTER TABLE [dbo].[lc_ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_ColorTable]
GO
ALTER TABLE [dbo].[lc_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[lc_Product] ([ProductID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[lc_ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Product]
GO
ALTER TABLE [dbo].[lc_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_SizeTable] FOREIGN KEY([SizeID])
REFERENCES [dbo].[lc_SizeTable] ([SizeID])
GO
ALTER TABLE [dbo].[lc_ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_SizeTable]
GO

--lc_CouponTable
CREATE TABLE [dbo].[lc_CouponTable](
	[CouponID] [int] IDENTITY(1,1) NOT NULL,
	[CouponName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CouponCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Amount] [money] NOT NULL CONSTRAINT [DF_CouponTable_Amount]  DEFAULT ((0)),
	[DiscountPercent] [decimal](18, 3) NOT NULL CONSTRAINT [DF_CouponTable_DiscountPercent]  DEFAULT ((0)),
	[ExpireDate] [smalldatetime] NOT NULL,
	[DateMade] [smalldatetime] NOT NULL CONSTRAINT [DF_CouponTable_DateMade]  DEFAULT (getdate()),
 CONSTRAINT [PK_CouponTable] PRIMARY KEY CLUSTERED 
(
	[CouponID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[lc_CouponTable]  WITH CHECK ADD  CONSTRAINT [FK_CouponTable_CouponTable] FOREIGN KEY([CouponID])
REFERENCES [dbo].[lc_CouponTable] ([CouponID])
GO
ALTER TABLE [dbo].[lc_CouponTable] CHECK CONSTRAINT [FK_CouponTable_CouponTable]
GO

--lc_State Tax Table
CREATE TABLE [dbo].[lc_StateTaxTable](
	[StateTaxTableID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TaxPercent] [float] NOT NULL,
 CONSTRAINT [PK_TaxTable] PRIMARY KEY CLUSTERED 
(
	[StateTaxTableID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--lc_Seller Table
CREATE TABLE [dbo].[lc_SellerTable](
	[SellerID] [int] IDENTITY(1,1) NOT NULL,
	[SellerName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Address] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Address2] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[State] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Zip] [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Country] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_SellerTable] PRIMARY KEY CLUSTERED 
(
	[SellerID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--lc_ProductImage
CREATE TABLE [dbo].[lc_ProductImage](
	[ProductImageID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ImageName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Title] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ProductImage] PRIMARY KEY CLUSTERED 
(
	[ProductImageID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[lc_ProductImage]  WITH CHECK ADD  CONSTRAINT [FK_ProductImage_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[lc_Product] ([ProductID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[lc_ProductImage] CHECK CONSTRAINT [FK_ProductImage_Product]
GO

--lc_ProductInventory
CREATE TABLE [dbo].[lc_ProductInventory](
	[ProductInventoryID] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Size] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Color] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SellerID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_ProductInventory1] PRIMARY KEY CLUSTERED 
(
	[ProductInventoryID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[lc_ProductInventory]  WITH CHECK ADD  CONSTRAINT [FK_ProductInventory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[lc_Product] ([ProductID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[lc_ProductInventory] CHECK CONSTRAINT [FK_ProductInventory_Product]
GO

--lc_Recommendation
CREATE TABLE [dbo].[lc_Recommendation](
	[RecommendationID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Title] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Approved] [bit] NULL,
	[Points] [int] NOT NULL,
	[DateInserted] [smalldatetime] NOT NULL,
	[UserName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Recommendation] PRIMARY KEY CLUSTERED 
(
	[RecommendationID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[lc_Recommendation]  WITH CHECK ADD  CONSTRAINT [FK_Recommendation_PRODUCTID] FOREIGN KEY([ProductID])
REFERENCES [dbo].[lc_Product] ([ProductID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[lc_Recommendation] CHECK CONSTRAINT [FK_Recommendation_PRODUCTID]
GO

--lc_WishList
CREATE TABLE [dbo].[lc_WishList](
	[WishListID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProductID] [int] NOT NULL,
	[DateAdded] [smalldatetime] NOT NULL,
	[SizeID] [int] NOT NULL,
	[ColorID] [int] NOT NULL,
 CONSTRAINT [PK_WishList] PRIMARY KEY CLUSTERED 
(
	[WishListID] ASC,
	[SizeID] ASC,
	[ColorID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[lc_WishList]  WITH CHECK ADD  CONSTRAINT [FK_WishList_Color] FOREIGN KEY([ColorID])
REFERENCES [dbo].[lc_ColorTable] ([ColorID])
GO
ALTER TABLE [dbo].[lc_WishList] CHECK CONSTRAINT [FK_WishList_Color]
GO
ALTER TABLE [dbo].[lc_WishList]  WITH CHECK ADD  CONSTRAINT [FK_WishList_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[lc_Product] ([ProductID])
GO
ALTER TABLE [dbo].[lc_WishList] CHECK CONSTRAINT [FK_WishList_Product]
GO
ALTER TABLE [dbo].[lc_WishList]  WITH CHECK ADD  CONSTRAINT [FK_WishList_Size] FOREIGN KEY([SizeID])
REFERENCES [dbo].[lc_SizeTable] ([SizeID])
GO
ALTER TABLE [dbo].[lc_WishList] CHECK CONSTRAINT [FK_WishList_Size]
GO

--lc_BillingInfoTable
CREATE TABLE [dbo].[lc_BillingInfoTable](
	[OrderID] [int] NOT NULL,
	[FirstName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LastName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MiddleName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NickName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Prefix] [char](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Address2] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[State] [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Zip] [nchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fax] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Country] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_BillingInfoTable] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--lc_ShippingInfoTable
CREATE TABLE [dbo].[lc_ShippingInfoTable](
	[OrderID] [int] NOT NULL,
	[FirstName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LastName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MiddleName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NickName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Prefix] [char](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Address2] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[State] [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Zip] [nchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fax] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Country] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_ShippingInfoTable] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--lc_ShippingRegion
CREATE TABLE [dbo].[lc_ShippingRegion](
	[ShippingRegionID] [int] IDENTITY(1,1) NOT NULL,
	[ShippingRegion] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ShippingRegion] PRIMARY KEY CLUSTERED 
(
	[ShippingRegionID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--lc_RegionShippingTable
CREATE TABLE [dbo].[lc_RegionShippingTable](
	[RegionID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ShippingCost] [float] NOT NULL,
 CONSTRAINT [PK_RegionShippingTable] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/* Add Country and State/Province Tables with Data */
--lc_Country
CREATE TABLE [dbo].[lc_Country](
    [CountryID] [int] IDENTITY(1,1) NOT NULL,
    [CountryGUID] [uniqueidentifier] NOT NULL CONSTRAINT DF_lc_Country_CountryGUID DEFAULT(newid()),
    [Name] [nvarchar](100) NOT NULL,
    [TwoCharCode] [nvarchar](2) NULL,
    [ThreeCharCode] [nvarchar](3) NULL,
    [NumCode] [nvarchar](3) NULL,
    [ShipTo] [bit] NOT NULL DEFAULT((1)),
    [Published] [tinyint] NOT NULL CONSTRAINT DF_lc_Country_Published DEFAULT((1)),
    [DisplayOrder] [int] NOT NULL CONSTRAINT DF_lc_Country_DisplayOrder DEFAULT((1)),
    [CreatedOn] [datetime] NOT NULL CONSTRAINT DF_lc_Country_CreatedOn DEFAULT(getdate()),
    CONSTRAINT [PK_lc_Country] PRIMARY KEY CLUSTERED 
    (
        [CountryID] ASC
    )
)
GO

-- lc_State
CREATE TABLE [dbo].[lc_State](
    [StateID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](100) NOT NULL,
    [CountryID] [int] NULL,
    [Abbreviation] [nvarchar](5) NOT NULL,
    [Published] [tinyint] NOT NULL CONSTRAINT DF_lc_State_Published DEFAULT((1)),
    [DisplayOrder] [int] NOT NULL CONSTRAINT DF_lc_State_DisplayOrder DEFAULT((1)),
    [CreatedOn] [datetime] NOT NULL CONSTRAINT DF_lc_State_CreatedOn DEFAULT(getdate()),
    CONSTRAINT [PK_lc_State] PRIMARY KEY CLUSTERED 
    (
        [StateID] ASC
    )
)
GO
ALTER TABLE [dbo].[lc_State]  WITH CHECK ADD  CONSTRAINT [FK_lc_State_lc_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[lc_Country] ([CountryID])
GO

-- ------------------------------------------------
-- Insert Values for Country and State/Province

-- US to be ID 1, and Canada to be ID 2
set IDENTITY_INSERT [dbo].[lc_Country] ON;
INSERT [dbo].[lc_Country](CountryID,Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values(1,'United States','US','USA','840',1);
INSERT [dbo].[lc_Country](CountryID,Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values(2,'Canada','CA','CAN','124',2);
set IDENTITY_INSERT [dbo].[lc_Country] OFF;
GO


INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Afghanistan','AF','AFG','004',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Albania','AL','ALB','008',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Algeria','DZ','DZA','012',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('American Samoa','AS','ASM','016',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Andorra','AD','AND','020',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Angola','AO','AGO','024',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Anguilla','AI','AIA','660',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Antarctica','AQ','ATA','010',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Antigua and Barbuda','AG','ATG','028',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Argentina','AR','ARG','032',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Armenia','AM','ARM','051',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Aruba','AW','ABW','533',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Australia','AU','AUS','036',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Austria','AT','AUT','040',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Azerbaijan','AZ','AZE','031',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Bahamas','BS','BHS','044',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Bahrain','BH','BHR','048',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Bangladesh','BD','BGD','050',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Barbados','BB','BRB','052',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Belarus','BY','BLR','112',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Belgium','BE','BEL','056',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Belize','BZ','BLZ','084',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Benin','BJ','BEN','204',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Bermuda','BM','BMU','060',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Bhutan','BT','BTN','064',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Bolivia','BO','BOL','068',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Bosnia and Herzegowina','BA','BIH','070',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Botswana','BW','BWA','072',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Bouvet Island','BV','BVT','074',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Brazil','BR','BRA','076',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('British Indian Ocean Territory','IO','IOT','086',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Brunei Darussalam','BN','BRN','096',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Bulgaria','BG','BGR','100',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Burkina Faso','BF','BFA','854',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Burundi','BI','BDI','108',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Cambodia','KH','KHM','116',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Cape Verde','CV','CPV','13',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Cayman Islands','KY','CYM','136',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Central African Republic','CF','CAF','140',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Chad','TD','TCD','148',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Chile','CL','CHL','152',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('China','CN','CHN','156',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Christmas Island','CX','CXR','162',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Cocos (Keeling) Islands','CC','CCK','166',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Colombia','CO','COL','170',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Comoros','KM','COM','174',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Congo','CG','COG','178',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Congo, the Democratic Republic of the','CD','COD','180',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Cook Islands','CK','COK','184',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Costa Rica','CR','CRI','188',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Cote d''Ivoire','CI','CIV','384',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Croatia (local Name: Hrvatska)','HR','HRV','191',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Cuba','CU','CUB','192',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Cyprus','CY','CYP','196',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Czech Republic','CZ','CZE','203',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Denmark','DK','DNK','208',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Djibouti','DJ','DJI','262',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Dominica','DM','DMA','212',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Dominican Republic','DO','DOM','214',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('East Timor','TP','TMP','626',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Ecuador','EC','ECU','218',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Egypt','EG','EGY','818',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('El Salvador','SV','SLV','222',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Estonia', 'EE', 'EST', '223', 2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Falkland Islands (Malvinas)','FK','FLK','238',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Faroe Islands','FO','FRO','234',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Fiji','FJ','FJI','242',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Finland','FI','FIN','246',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('France','FR','FRA','250',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('France, Metropolitan','FX','FXX','249',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('French Guiana','GF','GUF','254',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('French Polynesia','PF','PYF','258',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('French Southern Territories','TF','ATF','260',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Gabon','GA','GAB','266',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Gambia','GM','GMB','270',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Georgia','GE','GEO','268',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Germany','DE','DEU','276',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Ghana','GH','GHA','288',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Gibraltar','GI','GIB','292',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Greece','GR','GRC','300',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Greenland','GL','GRL','304',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Grenada','GD','GRD','308',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Guadeloupe','GP','GLP','312',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Guam','GU','GUM','316',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Guatemala','GT','GTM','320',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Guinea','GN','GIN','324',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Guinea-Bissau','GW','GNB','624',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Guyana','GY','GUY','328',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Haiti','HT','HTI','332',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Heard and Mc Donald Islands','HM','HMD','334',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Holy see (Vatican City State)','VA','VAT','336',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Honduras','HN','HND','340',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Hong Kong','HK','HKG','344',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Hungary','HU','HUN','348',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Iceland','IS','ISL','352',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('India','IN','IND','356',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Indonesia','ID','IDN','360',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Iran (Islamic Republic of)','IR','IRN','364',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Iraq','IQ','IRQ','368',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Ireland','IE','IRL','372',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Israel','IL','ISR','376',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Italy','IT','ITA','380',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Jamaica','JM','JAM','388',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Japan','JP','JPN','392',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Jordan','JO','JOR','400',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Kazakhstan','KZ','KAZ','398',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Kenya','KE','KEN','404',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Kiribati','KI','KIR','296',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Korea, Democratic People''s Republic of','KP','PRK','408',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Korea, Republic of','KR','KOR','410',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Kuwait','KW','KWT','414',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Kyrgyzstan','KG','KGZ','417',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Lao People''s Democratic Republic','LA','LAO','418',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Latvia','LV','LVA','428',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Lebanon','LB','LBN','422',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Lesotho','LS','LSO','426',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Liberia','LR','LBR','430',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Libyan Arab Jamahiriya','LY','LBY','434',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Liechtenstein','LI','LIE','438',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Lithuania','LT','LTU','440',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Luxembourg','LU','LUX','442',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Macau','MO','MAC','446',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Macedonia, the former Yugoslav Republic of','MK','MKD','807',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Madagascar','MG','MDG','400',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Malawi','MW','MWI','454',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Malaysia','MY','MYS','458',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Maldives','MV','MDV','462',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Mali','ML','MLI','466',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Malta','MT','MLT','470',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Marshall Islands','MH','MHL','584',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Martinique','MQ','MTQ','474',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Mauritania','MR','MRT','478',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Mauritius','MU','MUS','480',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Mayotte','YT','MYT','175',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Mexico','MX','MEX','484',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Micronesia, Federated States of','FM','FSM','583',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Moldova, Republic of','MD','MDA','498',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Monaco','MC','MCO','492',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Mongolia','MN','MNG','496',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Montserrat','MS','MSR','500',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Morocco','MA','MAR','504',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Mozambique','MZ','MOZ','508',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Myanmar','MM','MMR','104',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Namibia','NA','NAM','516',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Nauru','NR','NRU','520',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Nepal','NP','NPL','524',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Netherlands','NL','NLD','528',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Netherlands Antilles','AN','ANT','530',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('New Caledonia','NC','NCL','540',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('New Zealand','NZ','NZL','554',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Nicaragua','NI','NIC','558',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Niger','NE','NER','562',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Nigeria','NG','NGA','566',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Niue','NU','NIU','570',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Norfolk Island','NF','NFK','574',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Northern Mariana Islands','MP','MNP','580',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Norway','NO','NOR','578',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Oman','OM','OMN','512',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Pakistan','PK','PAK','586',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Palau','PW','PLW','585',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Palestinian Territory','PS','PSE','275',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Panama','PA','PAN','591',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Papua New Guinea','PG','PNG','598',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Paraguay','PY','PRY','600',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Peru','PE','PER','604',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Philippines','PH','PHL','608',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Pitcairn','PN','PCN','612',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Poland','PL','POL','616',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Portugal','PT','PRT','620',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Puerto Rico','PR','PRI','630',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Qatar','QA','QAT','634',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Reunion','RE','REU','638',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Romania','RO','ROM','642',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Russia','RU','RUS','643',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Rwanda','RW','RWA','646',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Saint Kitts and Nevis','KN','KNA','659',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Saint Lucia','LC','LCA','662',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Saint Vincent and the Grenadines','VC','VCT','670',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Samoa','WS','WSM','882',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('San Marino','SM','SMR','674',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Sao Tome and Principe','ST','STP','678',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Saudi Arabia','SA','SAU','682',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Senegal','SN','SEN','686',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Seychelles','SC','SYC','690',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Sierra Leone','SL','SLE','694',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Singapore','SG','SGP','702',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Slovakia (Slovak Republic)','SK','SVK','703',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Slovenia','SI','SVN','705',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Solomon Islands','SB','SLB','090',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Somalia','SO','SOM','706',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('South Africa','ZA','ZAF','710',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('South Georgia and the South Sandwich Islands','GS','SGS','239',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Spain','ES','ESP','724',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Sri Lanka','LK','LKA','144',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('St. Helena','SH','SHN','654',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('St. Pierre and Miquelon','PM','SPM','666',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Sudan','SD','SDN','736',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('SuriName','SR','SUR','740',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Svalbard and Jan Mayen Islands','SJ','SJM','744',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Swaziland','SZ','SWZ','748',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Sweden','SE','SWE','752',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Switzerland','CH','CHE','756',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Syria','SY','SYR','760',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Taiwan','TW','TWN','158',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Tajikistan','TJ','TJK','762',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Tanzania, United Republic of','TZ','TZA','834',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Thailand','TH','THA','764',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Togo','TG','TGO','768',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Tokelau','TK','TKL','772',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Tonga','TO','TON','776',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Trinidad and Tobago','TT','TTO','780',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Tunisia','TN','TUN','788',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Turkey','TR','TUR','792',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Turkmenistan','TM','TKM','795',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Turks and Caicos Islands','TC','TCA','796',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Tuvalu','TV','TUV','798',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Uganda','UG','UGA','800',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Ukraine','UA','UKR','804',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('United Arab Emirates','AE','ARE','784',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('United Kingdom','GB','GBR','826',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('United States minor outlying islands','UM','UMI','581',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Uruguay','UY','URY','858',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Uzbekistan','UZ','UZB','860',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Vanuatu','VU','VUT','548',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Venezuela','VE','VEN','862',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Viet Nam','VN','VNM','704',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Virgin Islands (British)','VG','VGB','092',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Virgin Islands (U.S.)','VI','VIR','850',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Wallis and Futuna Islands','WF','WLF','876',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Western Sahara','EH','ESH','732',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Yemen','YE','YEM','887',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Yugoslavia','YU','YUG','891',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Zambia','ZM','ZMB','894',2);
INSERT [dbo].[lc_Country](Name,TwoCharCode,ThreeCharCode,NumCode,DisplayOrder) values('Zimbabwe','ZW','ZWE','716',2);
GO

-- Add States/provinces for US and Canada. 
-- States
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Alabama','AL',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Alaska','AK',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'American Samoa','AS',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'AA (Armed Forces Americas)','AA',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'AE (Armed Forces Europe)','AE',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'AP (Armed Forces Pacific)','AP',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Arizona','AZ',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Arkansas','AR',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'California','CA',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Colorado','CO',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Connecticut','CT',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Delaware','DE',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'District of Columbia','DC',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Federated States of Micronesia','FM',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Florida','FL',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Georgia','GA',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Guam','GU',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Hawaii','HI',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Idaho','ID',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Illinois','IL',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Indiana','IN',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Iowa','IA',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Kansas','KS',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Kentucky','KY',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Louisiana','LA',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Maine','ME',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Marshall Islands','MH',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Maryland','MD',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Massachusetts','MA',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Michigan','MI',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Minnesota','MN',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Mississippi','MS',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Missouri','MO',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Montana','MT',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Northern Mariana Islands','MP',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Nebraska','NE',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Nevada','NV',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'New Hampshire','NH',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'New Jersey','NJ',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'New Mexico','NM',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'New York','NY',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'North Carolina','NC',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'North Dakota','ND',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Ohio','OH',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Oklahoma','OK',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Oregon','OR',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Palau','PW',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Pennsylvania','PA',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Puerto Rico','PR',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Rhode Island','RI',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'South Carolina','SC',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'South Dakota','SD',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Tennessee','TN',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Texas','TX',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Utah','UT',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Vermont','VT',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Virgin Islands','VI',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Virginia','VA',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Washington','WA',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'West Virginia','WV',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Wisconsin','WI',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(1,'Wyoming','WY',1);
GO

-- Provinces
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'Alberta','AB',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'British Columbia','BC',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'Manitoba','MB',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'New Brunswick','NB',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'Newfoundland and Labrador', 'NL',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'Northwest Territories','NT',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'Nova Scotia','NS',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'Nunavut','NU',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'Ontario','ON',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'Prince Edward Island','PE',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'Quebec','QC',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'Saskatchewan','SK',1);
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(2,'Yukon Territory','YU',1);
GO
--For Others Countries
INSERT [dbo].[lc_State](CountryID,Name,Abbreviation,DisplayOrder) values(null,'Other','--',1);
GO




--Stored Procedures

--GetProductRecommendations

CREATE PROCEDURE GetProductRecommendations
(@ProductID INT,
 @DescriptionLength INT)
AS
SELECT ProductID, 
       Name, 
       Image1FileName,
       Price,
       SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description
FROM lc_Product
WHERE ProductID IN
    (
    SELECT TOP 5 od2.ProductID
    FROM lc_OrderDetail od1
    JOIN lc_OrderDetail od2 ON od1.OrderID = od2.OrderID
    WHERE od1.ProductID = @ProductID AND od2.ProductID != @ProductID
    GROUP BY od2.ProductID
    ORDER BY COUNT(od2.ProductID) DESC
    )

GO
--GetAllProductsInCategory
Create Procedure [dbo].[GetAllProductsInCategory]
(@CategoryID int)
as
SELECT     Product.ProductID, Product.Name, Product.Description, Product.Price, Product.Image1FileName, Product.Image2FileName, Product.OnCatalogPromotion, 
                      Product.OnDepartmentPromotion
FROM         lc_Product as Product INNER JOIN
                      lc_ProductCategory as ProductCategory ON Product.ProductID = ProductCategory.ProductID
WHERE     (ProductCategory.CategoryID = @CategoryID)
