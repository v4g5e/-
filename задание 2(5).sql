
USE EnhancedProductionDB;
GO

-- �������� ������ (� �������, ����������� ����������� ������� ������)

-- �����������
CREATE TABLE [dbo].[Region](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](100) NOT NULL,
    [Code] [nvarchar](10) NULL,
    [DeliveryMultiplier] [decimal](5, 2) NOT NULL,
    [IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[City](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](100) NOT NULL,
    [RegionID] [int] NOT NULL,
    [PostalCode] [nvarchar](20) NULL,
    [Latitude] [decimal](9, 6) NULL,
    [Longitude] [decimal](9, 6) NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_City_Region] FOREIGN KEY ([RegionID]) REFERENCES [dbo].[Region]([ID])
);
GO

CREATE TABLE [dbo].[UserRole](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [RoleName] [nvarchar](50) NOT NULL,
    [Description] [nvarchar](200) NULL,
    [Permissions] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[AgentType](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](50) NOT NULL,
    [Image] [nvarchar](100) NULL,
 CONSTRAINT [PK_AgentType] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[MaterialType](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](50) NOT NULL,
    [DefectedPercent] [float] NOT NULL,
 CONSTRAINT [PK_MaterialType] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[ProductType](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](50) NOT NULL,
    [DefectedPercent] [float] NOT NULL,
 CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[OrderStatus](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [StatusName] [nvarchar](50) NOT NULL,
    [Description] [nvarchar](200) NULL,
    [SortOrder] [int] NULL,
    [Color] [nvarchar](20) NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[PaymentType](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [Description] [nvarchar](200) NULL,
    [RequiresAdvance] [bit] NOT NULL,
    [AdvancePercent] [decimal](5, 2) NULL,
 CONSTRAINT [PK_PaymentType] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[Department](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](100) NOT NULL,
    [Description] [nvarchar](max) NULL,
    [IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[Position](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](100) NOT NULL,
    [Description] [nvarchar](max) NULL,
    [BaseSalary] [decimal](10, 2) NULL,
    [RequiredExperience] [int] NULL,
    [IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[AccessPoint](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](100) NOT NULL,
    [Location] [nvarchar](200) NULL,
    [Type] [nvarchar](50) NULL,
    [IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_AccessPoint] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[Shift](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [StartTime] [time](7) NOT NULL,
    [EndTime] [time](7) NOT NULL,
    [BreakDuration] [int] NOT NULL,
    [IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Shift] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[Workshop](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Number] [int] NOT NULL,
    [Name] [nvarchar](100) NOT NULL,
    [Description] [nvarchar](max) NULL,
    [MaxCapacity] [int] NOT NULL,
    [IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Workshop] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[NotificationTemplate](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](100) NOT NULL,
    [Content] [nvarchar](max) NOT NULL,
    [Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_NotificationTemplate] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

CREATE TABLE [dbo].[Supplier](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](150) NOT NULL,
    [INN] [varchar](12) NOT NULL,
    [StartDate] [date] NOT NULL,
    [QualityRating] [int] NULL,
    [SupplierType] [nvarchar](20) NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

-- �������� �������
CREATE TABLE [dbo].[User](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Login] [nvarchar](50) NOT NULL,
    [PasswordHash] [nvarchar](255) NOT NULL,
    [Email] [nvarchar](255) NOT NULL,
    [FirstName] [nvarchar](50) NOT NULL,
    [LastName] [nvarchar](50) NOT NULL,
    [MiddleName] [nvarchar](50) NULL,
    [UserRoleID] [int] NOT NULL,
    [IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_User_UserRole] FOREIGN KEY ([UserRoleID]) REFERENCES [dbo].[UserRole]([ID])
);
GO

CREATE TABLE [dbo].[Agent](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](150) NOT NULL,
    [AgentTypeID] [int] NOT NULL,
    [Address] [nvarchar](300) NULL,
    [INN] [varchar](12) NOT NULL,
    [KPP] [varchar](9) NULL,
    [DirectorName] [nvarchar](100) NULL,
    [Phone] [nvarchar](20) NOT NULL,
    [Email] [nvarchar](255) NULL,
    [Logo] [nvarchar](100) NULL,
    [Priority] [int] NOT NULL,
    [CityID] [int] NULL,
 CONSTRAINT [PK_Agent] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_Agent_AgentType] FOREIGN KEY ([AgentTypeID]) REFERENCES [dbo].[AgentType]([ID]),
 CONSTRAINT [FK_Agent_City] FOREIGN KEY ([CityID]) REFERENCES [dbo].[City]([ID])
);
GO

CREATE TABLE [dbo].[Employee](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Code] [nvarchar](50) NOT NULL,
    [FirstName] [nvarchar](50) NOT NULL,
    [LastName] [nvarchar](50) NOT NULL,
    [MiddleName] [nvarchar](50) NULL,
    [BirthDate] [date] NULL,
    [HireDate] [date] NOT NULL,
    [DepartmentID] [int] NOT NULL,
    [PositionID] [int] NOT NULL,
    [UserID] [int] NULL,
    [Phone] [nvarchar](20) NULL,
    [Email] [nvarchar](255) NULL,
    [NFCCardID] [int] NULL,
    [IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_Employee_Department] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Department]([ID]),
 CONSTRAINT [FK_Employee_Position] FOREIGN KEY ([PositionID]) REFERENCES [dbo].[Position]([ID]),
 CONSTRAINT [FK_Employee_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User]([ID])
);
GO

CREATE TABLE [dbo].[NFCCard](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [CardNumber] [nvarchar](50) NOT NULL,
    [IssueDate] [date] NOT NULL,
    [ExpirationDate] [date] NULL,
    [IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_NFCCard] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_Employee_NFCCard] FOREIGN KEY ([NFCCardID]) REFERENCES [dbo].[NFCCard]([ID]);
GO

CREATE TABLE [dbo].[Warehouse](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](100) NOT NULL,
    [Address] [nvarchar](200) NULL,
    [ResponsibleEmployeeID] [int] NULL,
    [IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_Warehouse_Employee] FOREIGN KEY ([ResponsibleEmployeeID]) REFERENCES [dbo].[Employee]([ID])
);
GO

CREATE TABLE [dbo].[WarehouseZone](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [WarehouseID] [int] NOT NULL,
    [ZoneName] [nvarchar](50) NOT NULL,
    [Temperature] [decimal](5, 1) NULL,
    [Humidity] [decimal](5, 1) NULL,
    [IsClimateControlled] [bit] NOT NULL,
 CONSTRAINT [PK_WarehouseZone] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_WarehouseZone_Warehouse] FOREIGN KEY ([WarehouseID]) REFERENCES [dbo].[Warehouse]([ID])
);
GO

CREATE TABLE [dbo].[Material](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](100) NOT NULL,
    [CountInPack] [int] NOT NULL,
    [Unit] [nvarchar](10) NOT NULL,
    [CountInStock] [float] NULL,
    [MinCount] [float] NOT NULL,
    [Description] [nvarchar](max) NULL,
    [Cost] [decimal](10, 2) NOT NULL,
    [Image] [nvarchar](100) NULL,
    [MaterialTypeID] [int] NOT NULL,
 CONSTRAINT [PK_Material] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_Material_MaterialType] FOREIGN KEY ([MaterialTypeID]) REFERENCES [dbo].[MaterialType]([ID])
);
GO

CREATE TABLE [dbo].[Product](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](100) NOT NULL,
    [ProductTypeID] [int] NULL,
    [ArticleNumber] [nvarchar](10) NOT NULL,
    [Description] [nvarchar](max) NULL,
    [Image] [nvarchar](100) NULL,
    [ProductionPersonCount] [int] NULL,
    [ProductionWorkshopNumber] [int] NULL,
    [MinCostForAgent] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_Product_ProductType] FOREIGN KEY ([ProductTypeID]) REFERENCES [dbo].[ProductType]([ID])
);
GO

CREATE TABLE [dbo].[Order](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [AgentID] [int] NOT NULL,
    [ManagerID] [int] NOT NULL,
    [CreateDate] [datetime] NOT NULL,
    [StatusID] [int] NOT NULL,
    [PrepaymentDate] [datetime] NULL,
    [FullPaymentDate] [datetime] NULL,
    [CancellationDate] [datetime] NULL,
    [DeliveryMethod] [nvarchar](50) NULL,
    [PaymentTypeID] [int] NOT NULL,
    [Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_Order_Agent] FOREIGN KEY ([AgentID]) REFERENCES [dbo].[Agent]([ID]),
 CONSTRAINT [FK_Order_Manager] FOREIGN KEY ([ManagerID]) REFERENCES [dbo].[User]([ID]),
 CONSTRAINT [FK_Order_OrderStatus] FOREIGN KEY ([StatusID]) REFERENCES [dbo].[OrderStatus]([ID]),
 CONSTRAINT [FK_Order_PaymentType] FOREIGN KEY ([PaymentTypeID]) REFERENCES [dbo].[PaymentType]([ID])
);
GO

CREATE TABLE [dbo].[OrderItem](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [OrderID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
    [Quantity] [int] NOT NULL,
    [AgreedPrice] [decimal](18,2) NOT NULL,
    [EstimatedProductionTime] [int] NOT NULL,
 CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_OrderItem_Order] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Order]([ID]),
 CONSTRAINT [FK_OrderItem_Product] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product]([ID])
);
GO

CREATE TABLE [dbo].[ProductionTask](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [OrderItemID] [int] NOT NULL,
    [WorkshopID] [int] NOT NULL,
    [PlannedStart] [date] NOT NULL,
    [PlannedEnd] [date] NOT NULL,
    [Status] [nvarchar](50) NOT NULL,
    [AssignedEmployeeID] [int] NULL,
 CONSTRAINT [PK_ProductionTask] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_ProductionTask_OrderItem] FOREIGN KEY ([OrderItemID]) REFERENCES [dbo].[OrderItem]([ID]),
 CONSTRAINT [FK_ProductionTask_Workshop] FOREIGN KEY ([WorkshopID]) REFERENCES [dbo].[Workshop]([ID]),
 CONSTRAINT [FK_ProductionTask_Employee] FOREIGN KEY ([AssignedEmployeeID]) REFERENCES [dbo].[Employee]([ID])
);
GO

CREATE TABLE [dbo].[AccessLog](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [EmployeeID] [int] NOT NULL,
    [AccessPointID] [int] NOT NULL,
    [AccessTime] [datetime] NOT NULL,
    [AccessType] [nvarchar](10) NOT NULL,
    [IsSuccessful] [bit] NOT NULL,
 CONSTRAINT [PK_AccessLog] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_AccessLog_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee]([ID]),
 CONSTRAINT [FK_AccessLog_AccessPoint] FOREIGN KEY ([AccessPointID]) REFERENCES [dbo].[AccessPoint]([ID])
);
GO

CREATE TABLE [dbo].[WorkSchedule](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [EmployeeID] [int] NOT NULL,
    [ShiftID] [int] NOT NULL,
    [ScheduleDate] [date] NOT NULL,
    [ActualStart] [datetime] NULL,
    [ActualEnd] [datetime] NULL,
 CONSTRAINT [PK_WorkSchedule] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_WorkSchedule_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee]([ID]),
 CONSTRAINT [FK_WorkSchedule_Shift] FOREIGN KEY ([ShiftID]) REFERENCES [dbo].[Shift]([ID])
);
GO

CREATE TABLE [dbo].[Equipment](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](100) NOT NULL,
    [SerialNumber] [nvarchar](50) NULL,
    [WorkshopID] [int] NOT NULL,
    [Status] [nvarchar](50) NOT NULL,
    [RequiredSpecialization] [nvarchar](max) NULL,
 CONSTRAINT [PK_Equipment] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_Equipment_Workshop] FOREIGN KEY ([WorkshopID]) REFERENCES [dbo].[Workshop]([ID])
);
GO

CREATE TABLE [dbo].[MaterialLocation](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [MaterialID] [int] NOT NULL,
    [WarehouseZoneID] [int] NOT NULL,
    [Quantity] [decimal](18,2) NOT NULL,
 CONSTRAINT [PK_MaterialLocation] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_MaterialLocation_Material] FOREIGN KEY ([MaterialID]) REFERENCES [dbo].[Material]([ID]),
 CONSTRAINT [FK_MaterialLocation_WarehouseZone] FOREIGN KEY ([WarehouseZoneID]) REFERENCES [dbo].[WarehouseZone]([ID])
);
GO

CREATE TABLE [dbo].[MaterialSupplier](
    [MaterialID] [int] NOT NULL,
    [SupplierID] [int] NOT NULL,
 CONSTRAINT [PK_MaterialSupplier] PRIMARY KEY CLUSTERED ([MaterialID] ASC, [SupplierID] ASC),
 CONSTRAINT [FK_MaterialSupplier_Material] FOREIGN KEY ([MaterialID]) REFERENCES [dbo].[Material]([ID]),
 CONSTRAINT [FK_MaterialSupplier_Supplier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[Supplier]([ID])
);
GO

CREATE TABLE [dbo].[ProductMaterial](
    [ProductID] [int] NOT NULL,
    [MaterialID] [int] NOT NULL,
    [Count] [float] NULL,
 CONSTRAINT [PK_ProductMaterial] PRIMARY KEY CLUSTERED ([ProductID] ASC, [MaterialID] ASC),
 CONSTRAINT [FK_ProductMaterial_Product] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product]([ID]),
 CONSTRAINT [FK_ProductMaterial_Material] FOREIGN KEY ([MaterialID]) REFERENCES [dbo].[Material]([ID])
);
GO

CREATE TABLE [dbo].[ProductSale](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [AgentID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
    [SaleDate] [date] NOT NULL,
    [ProductCount] [int] NOT NULL,
 CONSTRAINT [PK_ProductSale] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_ProductSale_Agent] FOREIGN KEY ([AgentID]) REFERENCES [dbo].[Agent]([ID]),
 CONSTRAINT [FK_ProductSale_Product] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product]([ID])
);
GO

CREATE TABLE [dbo].[Shop](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](150) NOT NULL,
    [Address] [nvarchar](300) NULL,
    [AgentID] [int] NOT NULL,
 CONSTRAINT [PK_Shop] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_Shop_Agent] FOREIGN KEY ([AgentID]) REFERENCES [dbo].[Agent]([ID])
);
GO

CREATE TABLE [dbo].[AgentPriorityHistory](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [AgentID] [int] NOT NULL,
    [ChangeDate] [datetime] NOT NULL,
    [PriorityValue] [int] NOT NULL,
 CONSTRAINT [PK_AgentPriorityHistory] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_AgentPriorityHistory_Agent] FOREIGN KEY ([AgentID]) REFERENCES [dbo].[Agent]([ID])
);
GO

CREATE TABLE [dbo].[AgentSalesPlan](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [AgentID] [int] NOT NULL,
    [PlanMonth] [date] NOT NULL,
    [PlanAmount] [decimal](15,2) NOT NULL,
    [ActualAmount] [decimal](15,2) NULL,
 CONSTRAINT [PK_AgentSalesPlan] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_AgentSalesPlan_Agent] FOREIGN KEY ([AgentID]) REFERENCES [dbo].[Agent]([ID])
);
GO

CREATE TABLE [dbo].[MaterialCountHistory](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [MaterialID] [int] NOT NULL,
    [ChangeDate] [datetime] NOT NULL,
    [CountValue] [float] NOT NULL,
 CONSTRAINT [PK_MaterialCountHistory] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_MaterialCountHistory_Material] FOREIGN KEY ([MaterialID]) REFERENCES [dbo].[Material]([ID])
);
GO

CREATE TABLE [dbo].[ProductCostHistory](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [ProductID] [int] NOT NULL,
    [ChangeDate] [datetime] NOT NULL,
    [CostValue] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_ProductCostHistory] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_ProductCostHistory_Product] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product]([ID])
);
GO

CREATE TABLE [dbo].[SystemLog](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NOT NULL,
    [Action] [nvarchar](100) NOT NULL,
    [Timestamp] [datetime] NOT NULL,
    [Details] [nvarchar](max) NULL,
 CONSTRAINT [PK_SystemLog] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_SystemLog_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User]([ID])
);
GO

CREATE TABLE [dbo].[Notification](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NOT NULL,
    [TemplateID] [int] NOT NULL,
    [SendDate] [datetime] NOT NULL,
    [IsRead] [bit] NOT NULL,
    [Parameters] [nvarchar](max) NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [FK_Notification_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User]([ID]),
 CONSTRAINT [FK_Notification_Template] FOREIGN KEY ([TemplateID]) REFERENCES [dbo].[NotificationTemplate]([ID])
);
GO

CREATE TABLE [dbo].[ReportTemplate](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](100) NOT NULL,
    [SQLQuery] [nvarchar](max) NOT NULL,
    [Description] [nvarchar](200) NULL,
    [RoleAccess] [nvarchar](200) NULL,
 CONSTRAINT [PK_ReportTemplate] PRIMARY KEY CLUSTERED ([ID] ASC)
);
GO

-- ������� ��� �������������� ������ ������ ����� 3 ��� ��� ������
CREATE TRIGGER [dbo].[AutoCancelOrder]
ON [dbo].[Order]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE [dbo].[Order]
    SET StatusID = (SELECT ID FROM [dbo].[OrderStatus] WHERE StatusName = N'�������'),
        CancellationDate = GETDATE(),
        Notes = ISNULL(o.Notes, '') + N' �������������� ������: ���������� �� ��������� � ������� 3 ����.'
    FROM [dbo].[Order] o
    INNER JOIN inserted i ON o.ID = i.ID
    WHERE o.StatusID IN (SELECT ID FROM [dbo].[OrderStatus] WHERE StatusName IN (N'�����', N'�� ������������', N'�����������'))
      AND o.PrepaymentDate IS NULL
      AND o.FullPaymentDate IS NULL
      AND DATEDIFF(DAY, o.CreateDate, GETDATE()) >= 3;
END;
GO

-- ������� ������ �� CSV (� ���������� �������, ����� �������� ���������� FK)

-- [REGIONS]
INSERT INTO [dbo].[Region] (Name, Code, DeliveryMultiplier, IsActive)
VALUES
(N'����������� ����������� �����', N'���', 1.0, 1),
(N'������-�������� ����������� �����', N'����', 1.2, 1),
(N'����� ����������� �����', N'���', 1.1, 1),
(N'������-���������� ����������� �����', N'����', 1.3, 1),
(N'����������� ����������� �����', N'���', 1.1, 1),
(N'��������� ����������� �����', N'���', 1.2, 1),
(N'��������� ����������� �����', N'���', 1.4, 1),
(N'��������������� ����������� �����', N'����', 1.6, 1);
GO

-- [CITIES]
INSERT INTO [dbo].[City] (Name, RegionID, PostalCode, Latitude, Longitude)
VALUES
(N'������', 1, N'101000', 55.7558, 37.6176),
(N'�����-���������', 2, N'190000', 59.9311, 30.3609),
(N'�����������', 7, N'630000', 55.0084, 82.9357),
(N'������������', 6, N'620000', 56.8431, 60.6454),
(N'������ ��������', 5, N'603000', 56.2965, 43.9361),
(N'������', 5, N'420000', 55.8304, 49.0661),
(N'���������', 6, N'454000', 55.1644, 61.4368),
(N'����', 7, N'644000', 54.9885, 73.3242),
(N'������', 5, N'443000', 53.2001, 50.15),
(N'������-��-����', 3, N'344000', 47.2357, 39.7015),
(N'���', 5, N'450000', 54.7388, 55.9721),
(N'����������', 7, N'660000', 56.0184, 92.8672),
(N'�������', 1, N'394000', 51.6720, 39.1843),
(N'�����', 5, N'614000', 58.0105, 56.2502),
(N'���������', 3, N'400000', 48.7080, 44.5133);
GO

INSERT INTO [dbo].[UserRole] (RoleName, Description, Permissions)
VALUES
(N'�������������', N'������ ������ � �������', N'{"users": "full", "orders": "full", "reports": "full", "settings": "full"}'),
(N'��������', N'���������� �������� � ��������', N'{"agents": "full", "orders": "full", "reports": "read"}'),
(N'������ ������������', N'���������� �������������', N'{"production": "full", "materials": "full", "equipment": "read"}'),
(N'��������', N'������ � �������� � ����������', N'{"reports": "full", "analytics": "full", "orders": "read"}'),
(N'���������', N'���������� �������', N'{"materials": "full", "warehouse": "full", "inventory": "full"}'),
(N'�����', N'�������� ����� ������', N'{"profile": "read", "orders": "own"}'),
(N'���������', N'���������� ��������', N'{"payments": "full", "reports": "financial", "agents": "read"}'),
(N'��������', N'������� ������', N'{"orders": "read", "materials": "read", "reports": "basic"}');
GO

INSERT INTO [dbo].[Department] (Name, Description, IsActive)
VALUES
(N'����������', N'���������������� �������', 1),
(N'������������', N'������������ ���������', 1),
(N'�����', N'��������� ��������', 1),
(N'����� ������', N'������ � ��������', 1),
(N'������������� �����', N'������ � ������������', 1),
(N'�����������', N'���������� ����', 1),
(N'IT-�����', N'����������� ���������', 1),
(N'����� ������', N'���������� ����������', 1),
(N'������ ������������', N'�������� �������', 1),
(N'���������', N'�������� � ���������', 1);
GO

INSERT INTO [dbo].[Position] (Title, Description, BaseSalary, RequiredExperience, IsActive)
VALUES
(N'����������� ��������', N'����������� ���������', 150000.00, 60, 1),
(N'�������� �� ��������', N'������ � ��������', 65000.00, 12, 1),
(N'������ ������������', N'�������� ������������', 75000.00, 24, 1),
(N'��������', N'������ ������', 55000.00, 6, 1),
(N'���������', N'��������� ��������', 40000.00, 0, 1),
(N'���������', N'������� �����', 50000.00, 12, 1),
(N'��������� �������������', N'IT ���������', 70000.00, 24, 1),
(N'HR-��������', N'���������� ����������', 60000.00, 12, 1),
(N'��������', N'����������� ������������', 35000.00, 0, 1),
(N'��������', N'�������� ���������', 45000.00, 12, 1),
(N'�������� ������������', N'������ �� ������������', 42000.00, 3, 1),
(N'��������� ��������', N'�������� ���������', 48000.00, 6, 1);
GO

INSERT INTO [dbo].[User] (Login, PasswordHash, Email, FirstName, LastName, MiddleName, UserRoleID, IsActive)
VALUES
(N'�������.�1', N'HASH123', N'�������.�1@company.ru', N'������', N'�������', N'����������', 3, 1),
(N'�������.�2', N'HASH123', N'�������.�2@company.ru', N'�������', N'�������', N'����������', 4, 1),
(N'���������.�3', N'HASH123', N'���������.�3@company.ru', N'�������', N'���������', N'����������', 7, 1),
(N'�������.�4', N'HASH123', N'�������.�4@company.ru', N'�������', N'�������', N'����������', 7, 1),
(N'������.�5', N'HASH123', N'������.�5@company.ru', N'���������', N'������', N'����������', 8, 1),
(N'��������.�6', N'HASH123', N'��������.�6@company.ru', N'������', N'��������', N'���������', 5, 1),
(N'��������.�7', N'HASH123', N'��������.�7@company.ru', N'�������', N'��������', N'���������', 8, 1),
(N'��������.�8', N'HASH123', N'��������.�8@company.ru', N'�����', N'��������', N'�������������', 4, 1),
(N'���������.�9', N'HASH123', N'���������.�9@company.ru', N'�����', N'���������', N'�������������', 7, 1),
(N'�������.�10', N'HASH123', N'�������.�10@company.ru', N'��������', N'�������', N'���������', 5, 1)
;
GO

INSERT INTO [dbo].[Employee] (Code, FirstName, LastName, MiddleName, BirthDate, HireDate, DepartmentID, PositionID, UserID, Phone, Email, NFCCardID, IsActive)
VALUES
(N'EMP001', N'������', N'�������', N'����������', '1985-03-15', '2020-01-10', 2, 3, 1, N'+79001234567', N'�������.�1@company.ru', NULL, 1),
(N'EMP002', N'�������', N'�������', N'����������', '1990-07-22', '2021-06-01', 5, 4, 2, N'+79001234568', N'�������.�2@company.ru', NULL, 1),
(N'EMP003', N'�������', N'��������', N'����������', '1988-11-10', '2019-03-15', 6, 6, 3, N'+79001234569', N'��������.�3@company.ru', NULL, 1),
(N'EMP004', N'�������', N'�������', N'����������', '1992-04-05', '2022-02-20', 6, 6, 4, N'+79001234570', N'�������.�4@company.ru', NULL, 1),
(N'EMP005', N'���������', N'�����', N'����������', '1987-09-12', '2020-11-11', 8, 8, 5, N'+79001234571', N'������.�5@company.ru', NULL, 1)
;
GO

INSERT INTO [dbo].[NFCCard] (CardNumber, IssueDate, ExpirationDate, IsActive)
VALUES
(N'CARD001', '2023-01-01', '2025-01-01', 1),
(N'CARD002', '2023-02-01', '2025-02-01', 1),
(N'CARD003', '2023-03-01', '2025-03-01', 1),
(N'CARD004', '2023-04-01', '2025-04-01', 1),
(N'CARD005', '2023-05-01', '2025-05-01', 1)
;
GO

INSERT INTO [dbo].[AgentType] (Title, Image)
VALUES
(N'������������', N'distributor.png'),
(N'��������� �������', N'retail.png'),
(N'������� ����������', N'wholesale.png'),
(N'�������', N'partner.png');
GO

INSERT INTO [dbo].[Agent] (Title, AgentTypeID, Address, INN, KPP, DirectorName, Phone, Email, Logo, Priority, CityID)
VALUES
(N'��� �������', 1, N'������, ��. ������, 10', N'123456789012', N'123456789', N'������ �.�.', N'+79001234567', N'romashka@company.ru', N'romashka.png', 1, 1),
(N'�� ������', 2, N'�����-���������, ��. ����, 5', N'987654321098', NULL, N'������ �.�.', N'+79001234568', N'petrov@company.ru', N'petrov.png', 2, 2),
(N'��� ������', 3, N'�����������, ��. �����������, 20', N'112233445566', N'112233445', N'������� �.�.', N'+79001234569', N'sun@company.ru', N'sun.png', 3, 3)
;
GO

INSERT INTO [dbo].[Warehouse] (Name, Address, ResponsibleEmployeeID, IsActive)
VALUES
(N'�������� �����', N'��������� �������� ������ �', 1, 1),
(N'����� ������� ���������', N'��������� �������� ������ �', 2, 1),
(N'��������� �����', N'���������������� �������� ������� 3', 3, 1);
GO

INSERT INTO [dbo].[WarehouseZone] (WarehouseID, ZoneName, Temperature, Humidity, IsClimateControlled)
VALUES
(1, N'���� �1', 20.0, 45.0, 1),
(1, N'���� �2', 18.0, 40.0, 1),
(1, N'���� �3', 22.0, 50.0, 0),
(2, N'���� �1', 20.0, 45.0, 1),
(2, N'���� �2', 20.0, 45.0, 1),
(3, N'���� �1', 15.0, 60.0, 0);
GO

INSERT INTO [dbo].[Material] (Title, CountInPack, Unit, CountInStock, MinCount, Description, Cost, Image, MaterialTypeID)
VALUES
(N'����� ��������', 100, N'��', 5000.0, 1000.0, N'�������� ����� 2 ��', 500.00, N'steel.png', 1),
(N'������ ���������', 10, N'�', 200.0, 50.0, N'��������� ������ �����', 300.00, N'paint.png', 2),
(N'������� ABS', 50, N'��', 1000.0, 200.0, N'������� ��� 3D ������', 1000.00, N'abs.png', 3)
;
GO

INSERT INTO [dbo].[ProductType] (Title, DefectedPercent)
VALUES
(N'������', 2.5),
(N'�����������', 1.8),
(N'�����������', 3.0);
GO

INSERT INTO [dbo].[Product] (Title, ProductTypeID, ArticleNumber, Description, Image, ProductionPersonCount, ProductionWorkshopNumber, MinCostForAgent)
VALUES
(N'���� �������', 1, N'ART001', N'������� ���� 120x80 ��', N'table.png', 2, 2, 5000.00),
(N'���� ������������', 1, N'ART002', N'������������ ���� � ������������', N'chair.png', 1, 2, 3000.00),
(N'����� �������������', 3, N'ART003', N'����� 500 ��', N'drill.png', 1, 2, 2000.00)
;
GO

INSERT INTO [dbo].[Order] (AgentID, ManagerID, CreateDate, StatusID, PaymentTypeID, Notes)
VALUES
(1, 1, '2024-01-01', 1, 1, NULL),
(2, 2, '2024-02-01', 2, 2, N'������� �����'),
(3, 3, '2024-03-01', 3, 3, NULL)
;
GO

INSERT INTO [dbo].[OrderItem] (OrderID, ProductID, Quantity, AgreedPrice, EstimatedProductionTime)
VALUES
(1, 1, 10, 5000.00, 5),
(2, 2, 20, 3000.00, 3),
(3, 3, 15, 2000.00, 7)
;
GO

INSERT INTO [dbo].[ProductionTask] (OrderItemID, WorkshopID, PlannedStart, PlannedEnd, Status, AssignedEmployeeID)
VALUES
(1, 1, '2024-01-05', '2024-01-10', N'Planned', 1),
(2, 2, '2024-02-05', '2024-02-08', N'InProgress', 2),
(3, 3, '2024-03-05', '2024-03-12', N'Planned', 3)
;
GO

INSERT INTO [dbo].[AccessLog] (EmployeeID, AccessPointID, AccessTime, AccessType, IsSuccessful)
VALUES
(1, 1, '2024-01-01 08:02:41', N'IN', 1),
(1, 6, '2024-01-01 10:04:41', N'OUT', 1),
(1, 7, '2024-01-01 09:43:41', N'IN', 0)
;
GO

CREATE VIEW [dbo].[DashboardMetrics] AS
SELECT 
    (SELECT COUNT(*) FROM [dbo].[Order] WHERE CreateDate >= CAST(GETDATE() AS DATE)) AS �����������������,
    (SELECT COUNT(*) FROM [dbo].[Order] WHERE StatusID = (SELECT ID FROM [dbo].[OrderStatus] WHERE StatusName = N'� ������������')) AS �������������,
    (SELECT COUNT(*) FROM [dbo].[Employee] WHERE IsActive = 1) AS ������������������,
    (SELECT COUNT(*) FROM [dbo].[Material] WHERE CountInStock < MinCount) AS �����������������������,
    (SELECT SUM(oi.Quantity * oi.AgreedPrice) FROM [dbo].[OrderItem] oi 
        JOIN [dbo].[Order] o ON oi.OrderID = o.ID 
        WHERE MONTH(o.CreateDate) = MONTH(GETDATE()) AND YEAR(o.CreateDate) = YEAR(GETDATE())) AS �������������,
    (SELECT AVG(QualityRating) FROM [dbo].[Supplier] WHERE QualityRating IS NOT NULL) AS �������������������������;
GO

CREATE VIEW [dbo].[AgentDetails] AS
SELECT 
    a.ID,
    a.Title AS ���������,
    at.Title AS ���������,
    a.Address AS �����,
    a.INN,
    a.DirectorName AS ��������,
    a.Phone AS �������,
    a.Email,
    a.Priority AS ���������,
    COUNT(DISTINCT s.ID) AS �������������������,
    COUNT(DISTINCT o.ID) AS �����������������,
    SUM(oi.Quantity * oi.AgreedPrice) AS ����������������,
    MAX(o.CreateDate) AS ��������������������
FROM [dbo].[Agent] a
LEFT JOIN [dbo].[AgentType] at ON a.AgentTypeID = at.ID
LEFT JOIN [dbo].[Shop] s ON a.ID = s.AgentID
LEFT JOIN [dbo].[Order] o ON a.ID = o.AgentID
LEFT JOIN [dbo].[OrderItem] oi ON o.ID = oi.OrderID
GROUP BY a.ID, a.Title, at.Title, a.Address, a.INN, a.DirectorName, a.Phone, a.Email, a.Priority;
GO

CREATE VIEW [dbo].[ProductionPipeline] AS
SELECT 
    pt.ID AS �������������������,
    o.ID AS �������������������,
    p.Title AS ����������������,
    oi.Quantity AS ����������,
    w.Name AS ������������,
    e.FirstName + ' ' + e.LastName AS ����������������������,
    pt.PlannedStart AS ���������������������,
    pt.PlannedEnd AS ������������������������,
    pt.Status AS ������,
    DATEDIFF(DAY, pt.PlannedStart, GETDATE()) AS �����������
FROM [dbo].[ProductionTask] pt
JOIN [dbo].[OrderItem] oi ON pt.OrderItemID = oi.ID
JOIN [dbo].[Order] o ON oi.OrderID = o.ID
JOIN [dbo].[Product] p ON oi.ProductID = p.ID
JOIN [dbo].[Workshop] w ON pt.WorkshopID = w.ID
JOIN [dbo].[Employee] e ON pt.AssignedEmployeeID = e.ID
WHERE pt.Status IN (N'Planned', N'InProgress');
GO

-- �������
CREATE NONCLUSTERED INDEX IX_Order_CreateDate_Status 
ON [dbo].[Order] (CreateDate, StatusID) 
INCLUDE (AgentID);
GO

CREATE NONCLUSTERED INDEX IX_AccessLog_EmployeeID_AccessTime 
ON [dbo].[AccessLog] (EmployeeID, AccessTime) 
INCLUDE (AccessType, AccessPointID);
GO

CREATE NONCLUSTERED INDEX IX_ProductionTask_WorkshopID_Status 
ON [dbo].[ProductionTask] (WorkshopID, Status) 
INCLUDE (PlannedStart, PlannedEnd);
GO

CREATE NONCLUSTERED INDEX IX_Material_TypeID_Stock 
ON [dbo].[Material] (MaterialTypeID, CountInStock) 
INCLUDE (Title, MinCount, Cost);
GO

SELECT TOP 10
    a.Title AS ���������,
    SUM(ps.ProductCount * p.MinCostForAgent) AS ����������������
FROM [dbo].[ProductSale] ps
INNER JOIN [dbo].[Agent] a ON ps.AgentID = a.ID
INNER JOIN [dbo].[Product] p ON ps.ProductID = p.ID
WHERE ps.SaleDate >= DATEADD(MONTH, -1, GETDATE())
GROUP BY a.Title
ORDER BY ���������������� DESC;
GO


SELECT
    w.Name AS ������������,
    COUNT(pt.ID) AS ��������������,
    AVG(DATEDIFF(DAY, pt.PlannedStart, pt.PlannedEnd)) AS ������������������������������,
    w.MaxCapacity AS �����������������������
FROM [dbo].[ProductionTask] pt
INNER JOIN [dbo].[Workshop] w ON pt.WorkshopID = w.ID
WHERE pt.Status IN (N'InProgress', N'Planned')
GROUP BY w.Name, w.MaxCapacity
ORDER BY �������������� DESC;
GO
SELECT
    e.FirstName + ' ' + e.LastName AS �������������,
    COUNT(CASE WHEN al.AccessType = N'IN' AND DATEPART(HOUR, al.AccessTime) > 9 THEN 1 END) AS ���������,
    COUNT(CASE WHEN al.AccessType = N'OUT' AND DATEPART(HOUR, al.AccessTime) < 17 THEN 1 END) AS �����������,
    AVG(DATEDIFF(MINUTE, ws.ActualStart, ws.ActualEnd)) AS ������������������
FROM [dbo].[AccessLog] al
INNER JOIN [dbo].[Employee] e ON al.EmployeeID = e.ID
LEFT JOIN [dbo].[WorkSchedule] ws ON al.EmployeeID = ws.EmployeeID AND CAST(al.AccessTime AS DATE) = ws.ScheduleDate
WHERE al.AccessTime >= DATEADD(MONTH, -1, GETDATE())
GROUP BY e.FirstName, e.LastName
ORDER BY ��������� DESC;
GO

SELECT
    m.Title AS �����������������,
    SUM(oi.Quantity * pm.Count) AS �����������������,
    m.CountInStock AS ��������������,
    CASE 
        WHEN SUM(oi.Quantity * pm.Count) > m.CountInStock THEN N'������������ - ��������'
        ELSE N'����������'
    END AS ������������
FROM [dbo].[OrderItem] oi
INNER JOIN [dbo].[ProductMaterial] pm ON oi.ProductID = pm.ProductID
INNER JOIN [dbo].[Material] m ON pm.MaterialID = m.ID
INNER JOIN [dbo].[Order] o ON oi.OrderID = o.ID
WHERE o.CreateDate >= DATEADD(MONTH, -1, GETDATE())
  AND o.StatusID IN (SELECT ID FROM [dbo].[OrderStatus] WHERE StatusName IN (N'�����', N'�����������', N'� ������������'))
GROUP BY m.Title, m.CountInStock
ORDER BY ����������������� DESC;
GO

SELECT
    a.Title AS ���������,
    asp.PlanAmount AS ����������,
    SUM(ps.ProductCount * p.MinCostForAgent) AS ������������������,
    (SUM(ps.ProductCount * p.MinCostForAgent) / NULLIF(asp.PlanAmount, 0) * 100) AS �����������������
FROM [dbo].[AgentSalesPlan] asp
INNER JOIN [dbo].[Agent] a ON asp.AgentID = a.ID
LEFT JOIN [dbo].[ProductSale] ps ON a.ID = ps.AgentID AND MONTH(ps.SaleDate) = MONTH(asp.PlanMonth)
LEFT JOIN [dbo].[Product] p ON ps.ProductID = p.ID
WHERE asp.PlanMonth = DATEADD(MONTH, -1, GETDATE())
GROUP BY a.Title, asp.PlanAmount
ORDER BY ����������������� DESC;
GO

SELECT * FROM [dbo].[Region]
SELECT * FROM [dbo].[City]
SELECT * FROM [dbo].[UserRole]
SELECT * FROM [dbo].[AgentType]
SELECT * FROM [dbo].[MaterialType]
SELECT * FROM [dbo].[ProductType]
SELECT * FROM [dbo].[OrderStatus]
SELECT * FROM [dbo].[PaymentType]
SELECT * FROM [dbo].[Department]
SELECT * FROM [dbo].[Position]
SELECT * FROM [dbo].[AccessPoint]
SELECT * FROM [dbo].[Shift]
SELECT * FROM [dbo].[Workshop]
SELECT * FROM [dbo].[NotificationTemplate]
SELECT * FROM [dbo].[Supplier]
SELECT * FROM [dbo].[User]
SELECT * FROM [dbo].[Agent]
SELECT * FROM [dbo].[Employee]
SELECT * FROM [dbo].[NFCCard]
SELECT * FROM [dbo].[Warehouse]
SELECT * FROM [dbo].[WarehouseZone]
SELECT * FROM [dbo].[Material]
SELECT * FROM [dbo].[Product]
SELECT * FROM [dbo].[Order]
SELECT * FROM [dbo].[OrderItem]
SELECT * FROM [dbo].[ProductionTask]
SELECT * FROM [dbo].[AccessLog]
SELECT * FROM [dbo].[WorkSchedule]
SELECT * FROM [dbo].[Equipment]
SELECT * FROM [dbo].[MaterialLocation]
SELECT * FROM [dbo].[MaterialSupplier]
SELECT * FROM [dbo].[ProductMaterial]
SELECT * FROM [dbo].[ProductSale]
SELECT * FROM [dbo].[Shop]
SELECT * FROM [dbo].[AgentPriorityHistory]
SELECT * FROM [dbo].[AgentSalesPlan]
SELECT * FROM [dbo].[MaterialCountHistory]
SELECT * FROM [dbo].[ProductCostHistory]
SELECT * FROM [dbo].[SystemLog]
SELECT * FROM [dbo].[Notification]
SELECT * FROM [dbo].[ReportTemplate]
