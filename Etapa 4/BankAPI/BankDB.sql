USE [master]
GO
/****** Object:  Database [Bank]    Script Date: 13/08/2023 05:47:42 p. m. ******/
CREATE DATABASE [Bank]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bank', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Bank.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Bank_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Bank_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Bank] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bank].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bank] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bank] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bank] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bank] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bank] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bank] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Bank] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bank] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bank] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bank] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bank] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bank] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bank] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bank] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bank] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Bank] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bank] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bank] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bank] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bank] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bank] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bank] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bank] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Bank] SET  MULTI_USER 
GO
ALTER DATABASE [Bank] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bank] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bank] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bank] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bank] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bank] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Bank] SET QUERY_STORE = ON
GO
ALTER DATABASE [Bank] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Bank]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 13/08/2023 05:47:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AccountType] [int] NOT NULL,
	[ClientID] [int] NULL,
	[Balance] [decimal](10, 2) NOT NULL,
	[RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountType]    Script Date: 13/08/2023 05:47:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Administrator]    Script Date: 13/08/2023 05:47:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administrator](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[PhoneNumber] [varchar](40) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Pwd] [varchar](50) NOT NULL,
	[AdminType] [varchar](30) NOT NULL,
	[RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BankTransaction]    Script Date: 13/08/2023 05:47:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankTransaction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[TransactionType] [int] NOT NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[ExternalAccountID] [int] NULL,
	[RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 13/08/2023 05:47:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[PhoneNumber] [varchar](40) NOT NULL,
	[Email] [varchar](50) NULL,
	[RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionType]    Script Date: 13/08/2023 05:47:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (1, 1, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(N'2023-08-03T19:15:46.497' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (2, 2, 1, CAST(10000.00 AS Decimal(10, 2)), CAST(N'2023-08-03T19:15:46.497' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (3, 1, 2, CAST(3000.00 AS Decimal(10, 2)), CAST(N'2023-08-03T19:15:46.497' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (4, 2, 2, CAST(14000.00 AS Decimal(10, 2)), CAST(N'2023-08-03T19:15:46.497' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (5, 1, NULL, CAST(0.00 AS Decimal(10, 2)), CAST(N'2023-08-03T20:16:49.510' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (6, 1, 9, CAST(0.00 AS Decimal(10, 2)), CAST(N'2023-08-03T21:25:40.407' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (7, 1, 10, CAST(0.00 AS Decimal(10, 2)), CAST(N'2023-08-06T14:54:31.310' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (8, 1, NULL, CAST(0.00 AS Decimal(10, 2)), CAST(N'2023-08-06T14:55:36.123' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (9, 1, NULL, CAST(0.00 AS Decimal(10, 2)), CAST(N'2023-08-06T18:30:17.897' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (10, 1, NULL, CAST(0.00 AS Decimal(10, 2)), CAST(N'2023-08-06T18:49:14.753' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (11, 1, 14, CAST(0.00 AS Decimal(10, 2)), CAST(N'2023-08-08T21:26:40.527' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (12, 1, 15, CAST(0.00 AS Decimal(10, 2)), CAST(N'2023-08-08T21:29:05.940' AS DateTime))
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[AccountType] ON 

INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (1, N'Personal', CAST(N'2023-08-03T19:05:33.217' AS DateTime))
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (2, N'Nómina', CAST(N'2023-08-03T19:05:33.217' AS DateTime))
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (3, N'Ahorro', CAST(N'2023-08-03T19:05:33.217' AS DateTime))
SET IDENTITY_INSERT [dbo].[AccountType] OFF
GO
SET IDENTITY_INSERT [dbo].[Administrator] ON 

INSERT [dbo].[Administrator] ([ID], [Name], [PhoneNumber], [Email], [Pwd], [AdminType], [RegDate]) VALUES (1, N'Rodrigo', N'8531426910', N'rodrigo@gmail.com', N'1234', N'Super', CAST(N'2023-08-11T23:26:55.530' AS DateTime))
INSERT [dbo].[Administrator] ([ID], [Name], [PhoneNumber], [Email], [Pwd], [AdminType], [RegDate]) VALUES (2, N'Maria', N'8536741236', N'maria@gmail.com', N'1234', N'Viewer', CAST(N'2023-08-11T23:26:55.530' AS DateTime))
SET IDENTITY_INSERT [dbo].[Administrator] OFF
GO
SET IDENTITY_INSERT [dbo].[BankTransaction] ON 

INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccountID], [RegDate]) VALUES (1, 1, 1, CAST(100.00 AS Decimal(10, 2)), NULL, CAST(N'2023-08-03T19:27:05.027' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccountID], [RegDate]) VALUES (2, 1, 3, CAST(200.00 AS Decimal(10, 2)), 123456, CAST(N'2023-08-03T19:27:05.027' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccountID], [RegDate]) VALUES (3, 3, 1, CAST(100.00 AS Decimal(10, 2)), NULL, CAST(N'2023-08-03T19:27:05.027' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccountID], [RegDate]) VALUES (4, 3, 3, CAST(250.00 AS Decimal(10, 2)), 454545, CAST(N'2023-08-03T19:27:05.027' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccountID], [RegDate]) VALUES (5, 1, 2, CAST(1000.00 AS Decimal(10, 2)), NULL, CAST(N'2023-08-03T20:44:08.123' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccountID], [RegDate]) VALUES (7, 1, 1, CAST(1000.00 AS Decimal(10, 2)), NULL, CAST(N'2023-08-03T21:25:40.410' AS DateTime))
SET IDENTITY_INSERT [dbo].[BankTransaction] OFF
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (1, N'Tovar', N'8124658574', N'tovar@gmail.com', CAST(N'2023-08-03T18:13:45.573' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (2, N'Ana', N'8964521385', NULL, CAST(N'2023-08-03T18:15:06.147' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (3, N'Carlos', N'9685741202', NULL, CAST(N'2023-08-03T18:16:29.227' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (4, N'Karen', N'8575412396', N'karen@hotmail.com', CAST(N'2023-08-03T18:17:16.313' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (6, N'Karla', N'8545635241', NULL, CAST(N'2023-08-03T20:09:04.627' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (7, N'Jona', N'854563210', N'jona@gmail.com', CAST(N'2023-08-03T20:09:58.753' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (9, N'Alejandro', N'85964585753', N'juan.perez@gmail.com', CAST(N'2023-08-03T21:25:40.403' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (10, N'Alberto', N'8645250396', N'alberto@gmail,com', CAST(N'2023-08-06T14:54:31.303' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (14, N'Edgar', N'8434697820', N'edgar@gmail.com', CAST(N'2023-08-08T21:26:40.523' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (15, N'Javier', N'8763018520', N'javier@gmail.com', CAST(N'2023-08-08T21:29:05.937' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (16, N'Santiago', N'8763018520', N'santiago@gmail.com', CAST(N'2023-08-08T21:29:12.387' AS DateTime))
SET IDENTITY_INSERT [dbo].[Client] OFF
GO
SET IDENTITY_INSERT [dbo].[TransactionType] ON 

INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (1, N'Depósito en Efectivo', CAST(N'2023-08-03T19:05:33.217' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (2, N'Retiro en Efectivo', CAST(N'2023-08-03T19:05:33.217' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (3, N'Depósito vía Transferencia', CAST(N'2023-08-03T19:05:33.217' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (4, N'Retiro vía Efectivo', CAST(N'2023-08-03T19:05:33.217' AS DateTime))
SET IDENTITY_INSERT [dbo].[TransactionType] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[AccountType] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[Administrator] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[BankTransaction] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[Client] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[TransactionType] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([AccountType])
REFERENCES [dbo].[AccountType] ([ID])
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Client] ([ID])
GO
ALTER TABLE [dbo].[BankTransaction]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[BankTransaction]  WITH CHECK ADD FOREIGN KEY([TransactionType])
REFERENCES [dbo].[TransactionType] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[InsertBankTransaction]    Script Date: 13/08/2023 05:47:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBankTransaction]
    @AccountID INT,
    @TransactionType INT,
    @Amount DECIMAL(10,2),
    @ExternalAccountID INT = NULL
AS

    DECLARE @CurrentBalance DECIMAL(10,2), @NewBalance DECIMAL(10,2);

    BEGIN TRANSACTION;
    SET @CurrentBalance = (SELECT Balance FROM Account WHERE ID = @AccountID);

    -- Obtener nuevo saldo
    IF @TransactionType = 2 OR @TransactionType = 4
        -- Retiros
        SET @NewBalance = @CurrentBalance - @Amount;
    ELSE
        -- Depósitos
        SET @NewBalance = @CurrentBalance + @Amount;

    IF @NewBalance < 0
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN -1;
        END

    UPDATE Account SET Balance = @NewBalance WHERE ID = @AccountID;

    INSERT INTO BankTransaction (AccountID, TransactionType, Amount, ExternalAccountID) 
    VALUES (@AccountID, @TransactionType, @Amount, @ExternalAccountID);

    COMMIT TRANSACTION;

GO
/****** Object:  StoredProcedure [dbo].[InsertClient]    Script Date: 13/08/2023 05:47:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertClient] 
    @Name VARCHAR(200),
    @PhoneNumber VARCHAR(40),
    @Email VARCHAR(50) = NULL
AS 
    IF EXISTS (SELECT * FROM Client WHERE Email = @Email)
    BEGIN
        RETURN -1;
    END

    INSERT INTO Client (Name, PhoneNumber, Email)
    VALUES (@Name, @PhoneNumber, @Email);
GO
/****** Object:  StoredProcedure [dbo].[SelectAccount]    Script Date: 13/08/2023 05:47:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAccount]
    @ClientID INT = NULL
AS

    IF @ClientID IS NULL

    BEGIN

        SELECT a.ID, acc.Name AS AccountName, c.Name AS ClientName, a.Balance, a.RegDate
        FROM Account a 
        JOIN AccountType acc ON a.AccountType = acc.ID
        LEFT JOIN Client c ON a.ClientID = c.ID;

    END

    ELSE
    BEGIN

        SELECT a.ID, acc.Name AS AccountName, c.Name AS ClientName, a.Balance, a.RegDate
        FROM Account a 
        JOIN AccountType acc ON a.AccountType = acc.ID
        LEFT JOIN Client c ON a.ClientID = c.ID
        WHERE a.ClientID = @ClientID;

    END

GO
/****** Object:  StoredProcedure [dbo].[SelectClient]    Script Date: 13/08/2023 05:47:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectClient]
    @ClientID INT = NULL
AS
    IF @ClientID IS NULL
    BEGIN
        SELECT * FROM Client;
    END
    ELSE
    BEGIN
        SELECT * FROM Client WHERE ID = @ClientID;
    END
GO
USE [master]
GO
ALTER DATABASE [Bank] SET  READ_WRITE 
GO
