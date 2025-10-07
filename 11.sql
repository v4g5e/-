USE CompanyDB;
GO

PRINT '=== Приведение базы к 3 нормальной форме ===';

IF OBJECT_ID('dbo.SupplierType', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.SupplierType (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(20) NOT NULL
    );
    PRINT 'Создана таблица SupplierType';
END
GO

INSERT INTO dbo.SupplierType (Title)
SELECT DISTINCT SupplierType
FROM dbo.Supplier
WHERE SupplierType IS NOT NULL;
GO

PRINT '(затронуто записей: ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ')';

ALTER TABLE dbo.Supplier
ADD SupplierTypeID INT NULL;
GO

UPDATE s
SET SupplierTypeID = st.ID
FROM dbo.Supplier s
JOIN dbo.SupplierType st ON s.SupplierType = st.Title;
GO

PRINT '(затронуто записей: ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ')';

ALTER TABLE dbo.Supplier
ADD CONSTRAINT FK_Supplier_SupplierType
FOREIGN KEY (SupplierTypeID) REFERENCES dbo.SupplierType(ID);
GO

ALTER TABLE dbo.Supplier DROP COLUMN SupplierType;
GO

IF OBJECT_ID('dbo.UnitType', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.UnitType (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(10) NOT NULL
    );
    PRINT 'Создана таблица UnitType';
END
GO

INSERT INTO dbo.UnitType (Title)
SELECT DISTINCT Unit
FROM dbo.Material
WHERE Unit IS NOT NULL;
GO

PRINT '(затронуто записей: ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ')';

ALTER TABLE dbo.Material
ADD UnitTypeID INT NULL;
GO

UPDATE m
SET UnitTypeID = ut.ID
FROM dbo.Material m
JOIN dbo.UnitType ut ON m.Unit = ut.Title;
GO

PRINT '(затронуто записей: ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ')';

ALTER TABLE dbo.Material
ADD CONSTRAINT FK_Material_UnitType
FOREIGN KEY (UnitTypeID) REFERENCES dbo.UnitType(ID);
GO

ALTER TABLE dbo.Material DROP COLUMN Unit;
GO

IF OBJECT_ID('dbo.MaterialDescription', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.MaterialDescription (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        MaterialID INT NOT NULL,
        Description NVARCHAR(MAX) NULL,
        Image NVARCHAR(100) NULL,
        FOREIGN KEY (MaterialID) REFERENCES dbo.Material(ID)
    );
    PRINT 'Создана таблица MaterialDescription';
END
GO

INSERT INTO dbo.MaterialDescription (MaterialID, Description, Image)
SELECT ID, Description, Image FROM dbo.Material
WHERE Description IS NOT NULL OR Image IS NOT NULL;
GO

PRINT '(затронуто записей: ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ')';

ALTER TABLE dbo.Material DROP COLUMN Description;
ALTER TABLE dbo.Material DROP COLUMN Image;
GO

PRINT '=== Проверка нормализации ===';
SELECT 'SupplierType' AS TableName, COUNT(*) AS Records FROM dbo.SupplierType
UNION ALL
SELECT 'UnitType', COUNT(*) FROM dbo.UnitType
UNION ALL
SELECT 'MaterialDescription', COUNT(*) FROM dbo.MaterialDescription;
GO

PRINT '===  База приведена к 3НФ ===';
PRINT 'Время выполнения: ' + CONVERT(NVARCHAR(30), GETDATE(), 126);