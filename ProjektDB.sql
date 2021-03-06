﻿/*
Deployment script for projekt

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "projekt"
:setvar DefaultFilePrefix "projekt"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [raporty]...';


GO
CREATE SCHEMA [raporty]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [dbo].[cennik]...';


GO
CREATE TABLE [dbo].[cennik] (
    [cennikID] INT           IDENTITY (1, 1) NOT NULL,
    [modelID]  INT           NOT NULL,
    [cena]     MONEY         NOT NULL,
    [dataOd]   SMALLDATETIME NULL,
    [dataDo]   SMALLDATETIME NULL,
    PRIMARY KEY CLUSTERED ([cennikID] ASC)
);


GO
PRINT N'Creating [dbo].[klient]...';


GO
CREATE TABLE [dbo].[klient] (
    [klientID]    INT          IDENTITY (1, 1) NOT NULL,
    [imie]        VARCHAR (20) NOT NULL,
    [nazwisko]    VARCHAR (30) NOT NULL,
    [nrDowodu]    CHAR (9)     NOT NULL,
    [miasto]      VARCHAR (20) NULL,
    [kodPocztowy] CHAR (6)     NULL,
    [adres]       VARCHAR (40) NULL,
    PRIMARY KEY CLUSTERED ([klientID] ASC),
    UNIQUE NONCLUSTERED ([nrDowodu] ASC)
);


GO
PRINT N'Creating [dbo].[marka]...';


GO
CREATE TABLE [dbo].[marka] (
    [markaID]      INT          IDENTITY (1, 1) NOT NULL,
    [nazwa]        VARCHAR (20) NOT NULL,
    [kraj]         VARCHAR (20) NULL,
    [rokZalozenia] CHAR (4)     NULL,
    PRIMARY KEY CLUSTERED ([markaID] ASC),
    UNIQUE NONCLUSTERED ([nazwa] ASC)
);


GO
PRINT N'Creating [dbo].[model]...';


GO
CREATE TABLE [dbo].[model] (
    [modelID]      INT          IDENTITY (1, 1) NOT NULL,
    [markaID]      INT          NOT NULL,
    [nazwa]        VARCHAR (20) NOT NULL,
    [rokProdukcji] CHAR (4)     NULL,
    [typSamochodu] VARCHAR (15) NULL,
    PRIMARY KEY CLUSTERED ([modelID] ASC),
    UNIQUE NONCLUSTERED ([nazwa] ASC)
);


GO
PRINT N'Creating [dbo].[pracownik]...';


GO
CREATE TABLE [dbo].[pracownik] (
    [pracownikID] INT          IDENTITY (1, 1) NOT NULL,
    [imie]        VARCHAR (20) NOT NULL,
    [nazwisko]    VARCHAR (30) NOT NULL,
    [pesel]       CHAR (11)    NOT NULL,
    [miasto]      VARCHAR (20) NULL,
    [kodPocztowy] CHAR (6)     NULL,
    [adres]       VARCHAR (40) NULL,
    PRIMARY KEY CLUSTERED ([pracownikID] ASC),
    UNIQUE NONCLUSTERED ([pesel] ASC)
);


GO
PRINT N'Creating [dbo].[zamowienie]...';


GO
CREATE TABLE [dbo].[zamowienie] (
    [zamowienieID]  INT           IDENTITY (1, 1) NOT NULL,
    [modelID]       INT           NOT NULL,
    [klientID]      INT           NOT NULL,
    [pracownikID]   INT           NOT NULL,
    [cenaSprzedazy] MONEY         NOT NULL,
    [dataSprzedazy] SMALLDATETIME NOT NULL,
    [dataOdbioru]   SMALLDATETIME NULL,
    [zrealizowane]  BIT           NULL,
    [oplacone]      BIT           NULL,
    PRIMARY KEY CLUSTERED ([zamowienieID] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[cennik]...';


GO
ALTER TABLE [dbo].[cennik]
    ADD DEFAULT -1 FOR [modelID];


GO
PRINT N'Creating unnamed constraint on [dbo].[model]...';


GO
ALTER TABLE [dbo].[model]
    ADD DEFAULT -1 FOR [markaID];


GO
PRINT N'Creating unnamed constraint on [dbo].[zamowienie]...';


GO
ALTER TABLE [dbo].[zamowienie]
    ADD DEFAULT -1 FOR [modelID];


GO
PRINT N'Creating unnamed constraint on [dbo].[zamowienie]...';


GO
ALTER TABLE [dbo].[zamowienie]
    ADD DEFAULT -1 FOR [klientID];


GO
PRINT N'Creating unnamed constraint on [dbo].[zamowienie]...';


GO
ALTER TABLE [dbo].[zamowienie]
    ADD DEFAULT -1 FOR [pracownikID];


GO
PRINT N'Creating unnamed constraint on [dbo].[zamowienie]...';


GO
ALTER TABLE [dbo].[zamowienie]
    ADD DEFAULT GETDATE() FOR [dataSprzedazy];


GO
PRINT N'Creating unnamed constraint on [dbo].[zamowienie]...';


GO
ALTER TABLE [dbo].[zamowienie]
    ADD DEFAULT 0 FOR [zrealizowane];


GO
PRINT N'Creating unnamed constraint on [dbo].[zamowienie]...';


GO
ALTER TABLE [dbo].[zamowienie]
    ADD DEFAULT 0 FOR [oplacone];


GO
PRINT N'Creating unnamed constraint on [dbo].[cennik]...';


GO
ALTER TABLE [dbo].[cennik]
    ADD FOREIGN KEY ([modelID]) REFERENCES [dbo].[model] ([modelID]) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT;


GO
PRINT N'Creating unnamed constraint on [dbo].[model]...';


GO
ALTER TABLE [dbo].[model]
    ADD FOREIGN KEY ([markaID]) REFERENCES [dbo].[marka] ([markaID]) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT;


GO
PRINT N'Creating unnamed constraint on [dbo].[zamowienie]...';


GO
ALTER TABLE [dbo].[zamowienie]
    ADD FOREIGN KEY ([modelID]) REFERENCES [dbo].[model] ([modelID]) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT;


GO
PRINT N'Creating unnamed constraint on [dbo].[zamowienie]...';


GO
ALTER TABLE [dbo].[zamowienie]
    ADD FOREIGN KEY ([klientID]) REFERENCES [dbo].[klient] ([klientID]) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT;


GO
PRINT N'Creating unnamed constraint on [dbo].[zamowienie]...';


GO
ALTER TABLE [dbo].[zamowienie]
    ADD FOREIGN KEY ([pracownikID]) REFERENCES [dbo].[pracownik] ([pracownikID]) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT;


GO
PRINT N'Creating unnamed constraint on [dbo].[cennik]...';


GO
ALTER TABLE [dbo].[cennik]
    ADD CHECK (cena>0);


GO
PRINT N'Creating unnamed constraint on [dbo].[zamowienie]...';


GO
ALTER TABLE [dbo].[zamowienie]
    ADD CHECK (cenaSprzedazy>0);


GO
PRINT N'Creating [raporty].[Widok2]...';


GO
CREATE VIEW [raporty].[Widok2]
AS
SELECT 
z.zamowienieID,
z.cenaSprzedazy,
c.cena,
(c.cena-z.cenaSprzedazy)/c.cena as rabat
FROM
[dbo].[zamowienie] AS z
INNER JOIN [dbo].[cennik] AS c ON z.modelID= c.modelID
GO
PRINT N'Creating [raporty].[Widok1]...';


GO
CREATE VIEW [raporty].[Widok1]
AS
SELECT
m.nazwa,
COUNT(z.zamowienieID) AS liczbaZamowien,
SUM(z.cenaSprzedazy) AS sumaKwotSprzedazy
FROM
[dbo].[marka] as m
INNER JOIN [dbo].[model] as mo ON m.markaID= mo.markaID
INNER JOIN [dbo].[zamowienie] as z ON  mo.modelID=z.modelID
GROUP BY
m.nazwa
GO
PRINT N'Creating [raporty].[Widok4]...';


GO
CREATE VIEW [raporty].[Widok4]
AS
SELECT
p.imie,
p.nazwisko,
COUNT(z.zamowienieID) AS liczbaZamowien,
SUM(z.cenaSprzedazy) AS lacznaKwota
FROM [dbo].[pracownik] AS p
INNER JOIN [dbo].[zamowienie] AS z ON p.[pracownikID]=z.[pracownikID]
GROUP BY p.imie,p.nazwisko
GO
PRINT N'Creating [raporty].[Widok3]...';


GO
CREATE VIEW [raporty].[Widok3]
AS
SELECT
m.nazwa,
z.zamowienieID
FROM	 
[dbo].[model] as m 
LEFT JOIN [dbo].[zamowienie] as z ON m.modelID = z.modelID
WHERE
z.zamowienieID IS NULL
AND m.nazwa <> 'Default'
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
