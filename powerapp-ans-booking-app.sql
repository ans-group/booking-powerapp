-- SQL Script to create required Tables, Views and Stored Procedures for PowerApp ANS Booking App.

-- Create Buildings Table
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ans_booking_buildings](
	[id] [int] IDENTITY(100001,1) NOT NULL,
	[building_name] [varchar](50) NOT NULL,
	[address_line1] [varchar](50) NULL,
	[address_line2] [varchar](50) NULL,
	[address_line3] [varchar](50) NULL,
	[address_city] [varchar](20) NULL,
	[address_country] [varchar](20) NULL,
	[address_postcode] [varchar](10) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ans_booking_buildings] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO

-- Create Notes Table
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ans_booking_notes](
	[id] [int] IDENTITY(100001,1) NOT NULL,
	[note_name] [varchar](50) NOT NULL,
	[text] [varchar](2048) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ans_booking_notes] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO

INSERT INTO [dbo].[ans_booking_notes] (note_name, text)
VALUES ('terms', 'We want you and your colleagues to stay safe. Before using this application to book a workspace, you must accept our terms of use below.1. You must only use the workspace that you have booked. 2. You must only use the workspace during the booking period. 3. Social Distancing rules must be adhered to at all times.4. Wash your hands frequently or use a hand sanitizer provided.');  

INSERT INTO [dbo].[ans_booking_notes] (note_name, text)
VALUES ('booking_notes', 'We want you and your colleagues to stay safe, please follow the rules below.1. You must only use the workspace that you have booked. 2. You must only use the workspace during the booking period. 3. Social Distancing rules must be adhered to at all times.4. Wash your hands frequently or use a hand sanitizer provided.')

-- Create Reservations Table
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ans_booking_reservations](
	[id] [int] IDENTITY(100001,1) NOT NULL,
	[spot_id] [int] NOT NULL,
	[reservation_date] [date] NOT NULL,
	[space_option_id] [int] NOT NULL,
	[outlook_id] [varchar](200) NULL,
	[user_id] [int] NOT NULL,
	[reservation_state] [bit] NULL,
	[reservation_start_time] [time](0) NOT NULL,
	[reservation_end_time] [time](0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ans_booking_reservations] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ans_booking_reservations] ADD  CONSTRAINT [reservation_state_cs]  DEFAULT ((1)) FOR [reservation_state]
GO

-- Create Space Options Table
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ans_booking_space_options](
	[id] [int] IDENTITY(100001,1) NOT NULL,
	[space_id] [int] NOT NULL,
	[option_name] [varchar](50) NOT NULL,
	[option_start_time] [time](0) NULL,
	[option_end_time] [time](0) NULL,
	[options_day_sunday] [bit] NULL,
	[options_day_monday] [bit] NULL,
	[options_day_tuesday] [bit] NULL,
	[options_day_wednesday] [bit] NULL,
	[options_day_thursday] [bit] NULL,
	[options_day_friday] [bit] NULL,
	[options_day_saturday] [bit] NULL,
	[space_option_enabled] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ans_booking_space_options] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO

-- Create Spaces Table
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ans_booking_spaces](
	[id] [int] IDENTITY(100001,1) NOT NULL,
	[building_id] [int] NOT NULL,
	[space_name] [varchar](50) NOT NULL,
	[space_capacity] [int] NULL,
	[floor_number] [varchar](50) NULL,
	[space_enabled] [bit] NULL,
	[space_notes] [varchar](2048) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ans_booking_spaces] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO

-- Create Spots Table
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ans_booking_spots](
	[id] [int] IDENTITY(100001,1) NOT NULL,
	[space_id] [int] NOT NULL,
	[spot_name] [varchar](50) NOT NULL,
	[spot_sanitised] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ans_booking_spots] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ans_booking_spots] ADD  CONSTRAINT [spot_sanitised_cs]  DEFAULT ((0)) FOR [spot_sanitised]
GO

-- Create Users Table
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ans_booking_users](
	[id] [int] IDENTITY(100001,1) NOT NULL,
	[full_name] [varchar](50) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[accepted_terms] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ans_booking_users] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[ans_booking_users] ADD  CONSTRAINT [uc_email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO


-- Create Reservations View
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ans_bookings_reservations_view]
AS
SELECT res.[id]
      ,spot.[spot_name]
      ,spot.[id] AS spot_id
      ,spot.[spot_sanitised]
      ,space.[space_name]
      ,space.[id] AS space_id
      ,building.[building_name]
      ,building.[id] AS building_id
      ,res.[reservation_date]
      ,res.[reservation_start_time] AS [option_start_time]
      ,res.[reservation_end_time] AS [option_end_time]
      ,res.[reservation_state]
      ,res.[outlook_id]
      ,users.[full_name]
      ,users.[email]
      ,users.[id] AS user_id

FROM ((((([dbo].[ans_booking_reservations] res
INNER JOIN [dbo].[ans_booking_spots] spot ON res.spot_id = spot.id)
INNER JOIN [dbo].[ans_booking_space_options] opt ON res.space_option_id = opt.id)
INNER JOIN [dbo].[ans_booking_spaces] space ON spot.space_id = space.id)
INNER JOIN [dbo].[ans_booking_buildings] building ON space.building_id = building.id)
INNER JOIN [dbo].[ans_booking_users] users ON res.user_id = users.id)
GO

-- Create Stored Procedures Update Space Capcity
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ans_booking_spaces_update_capacity_sp] 
    @space_id INT

AS
BEGIN
    DECLARE @capacity INT
    SET @capacity = (SELECT COUNT(*) FROM [dbo].[ans_booking_spots] WHERE space_id = @space_id)

    UPDATE [dbo].[ans_booking_spaces] 
    SET space_capacity = @capacity
    WHERE id = @space_id
END;
GO

-- Create Stored Procedures Update Spot Availability
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ans_booking_spots_availability_sp] 
    @space_id INT,
    @start TIME(0),
    @end TIME(0),
    @date DATE

AS
BEGIN
    SELECT
        spot.id,
        spot.spot_name,
        spot.spot_sanitised

    FROM [ans_booking_spots] spot
        LEFT JOIN [ans_booking_spaces] spaces ON spot.space_id = spaces.id  

    WHERE spot.space_id = @space_id

    EXCEPT
    SELECT
        res.spot_id,
        spot.spot_name,
        spot.spot_sanitised
    FROM 
        [ans_booking_reservations] res
        LEFT JOIN [ans_booking_space_options] opt ON res.space_option_id = opt.id
        LEFT JOIN [ans_booking_spots] spot ON res.spot_id = spot.id

    WHERE res.reservation_date = @date 
        AND spot.space_id = @space_id
        AND res.reservation_state = 1
        AND (@end >= opt.option_start_time AND @start <= opt.option_end_time);
END;
GO

-- Create Stored Procedures Check Spot Status
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ans_booking_spots_check_status_sp] 
    @current_time TIME(0),
    @current_date DATE

AS
BEGIN
    SELECT *
    FROM [dbo].[ans_bookings_reservations_view] res
    WHERE res.reservation_date = @current_date AND @current_time >= DATEADD(MINUTE, -15, res.option_start_time) AND @current_time <= DATEADD(MINUTE, -10, res.option_start_time)
END;
GO

-- Create Stored Procedures Create Spot Reservation
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ans_booking_spots_reservation_sp] 
    @spot_id INT,
    @option_id INT,
    @date DATE,
    @user_id INT,
    @outlook_id VARCHAR(200)

AS
BEGIN
    DECLARE @available_spot_id INT;

    SET @available_spot_id = (
        SELECT
            spot_id
        FROM 
            [dbo].[ans_booking_reservations]
        WHERE
            reservation_date = @date 
            AND spot_id = @spot_id 
            AND space_option_id = @option_id
    )

    SELECT @available_spot_id;
    
    IF @available_spot_id IS NULL 

    DECLARE @reservation_start_time TIME(0)
    DECLARE @reservation_end_time TIME(0)

    SET @reservation_start_time = (SELECT option_start_time FROM [dbo].[ans_booking_space_options] WHERE id = @option_id)
    SET @reservation_end_time = (SELECT option_end_time FROM [dbo].[ans_booking_space_options] WHERE id = @option_id)

    BEGIN
        INSERT INTO [dbo].[ans_booking_reservations] (spot_id, user_id, reservation_date, reservation_start_time, reservation_end_time, space_option_id, outlook_id)
        VALUES(@spot_id, @user_id, @date, @reservation_start_time, @reservation_end_time, @option_id, @outlook_id)
    END;

END;
GO

-- Create Stored Procedures Update Date Spot Sanitised
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ans_booking_spots_update_not_sanitised_sp] 
    @current_time TIME(0),
    @current_date DATE

AS
BEGIN
    UPDATE [dbo].[ans_booking_spots]
    SET [dbo].[ans_booking_spots].[spot_sanitised] = 0

    FROM (([dbo].[ans_booking_reservations] res
    INNER JOIN [dbo].[ans_booking_space_options] opt ON res.space_option_id = opt.id)
    INNER JOIN [dbo].[ans_booking_spots] spot ON res.spot_id = spot.id)
    WHERE  @current_time >= DATEADD(MINUTE, -15, opt.option_end_time) AND @current_time <= DATEADD(MINUTE, -10, opt.option_end_time) AND res.reservation_date = @current_date
END;
GO
