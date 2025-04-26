-- Create the database
CREATE DATABASE youtube_mx_db;

-- Create the table to store YouTube data
CREATE TABLE IF NOT EXISTS youtube_mx
(
    rank smallint,
    name character varying(100),
    followers character varying(50),
    er character varying(50),
    country character varying(50),
    topic_of_influence character varying(50),
    potential_reach character varying(50),
    channel_name character varying(100),
    total_subscribers integer,
    total_views bigint,
    total_videos integer
);


/* After importing the data into the newly created table, 
verify that the data was properly loaded */
SELECT * 
FROM youtube_mx
LIMIT 10;


-- Create a view to simplify the data by selecting specific columns 
/* To practice SQL, you can create a view with the following columns: 

CREATE VIEW view_mex_youtubers AS 
	SELECT SUBSTRING(name, 1, strpos(name, '@') -1)::VARCHAR(100) AS 
		channel_name, total_subscribers, total_views, total_videos FROM youtube_mx; 
*/ 


/* However, since the channel_name is already correctly formatted from our Python script, 
and I manually entered stats for two channels at the end of the table, 
we will create the view with these columns:
*/
CREATE view view_mex_youtubers AS
	SELECT
		channel_name,
 		total_subscribers, 
 		total_views,
 		total_videos
 	FROM
 		youtube_mx;


-- Data quality check: 
-- Verify the number of rows (Top 100 YouTube channels)
SELECT
	COUNT(*) AS num_rows
FROM
	view_mex_youtubers;


-- Verify the number of columns 
-- (channel_name, total_subscribers, total_views, total_videos)
SELECT 
	COUNT(*) AS column_count
FROM
	information_schema.columns
WHERE 
	TABLE_NAME ='view_mex_youtubers';


-- Check the data type of each variable
SELECT 
	column_name,
	data_type
FROM
	information_schema.columns
WHERE 
	TABLE_NAME ='view_mex_youtubers';


-- Check the number of unique channels in the database
SELECT
	COUNT(DISTINCT(channel_name)) AS unique_channels
FROM
	view_mex_youtubers;


-- Alternatively, count the number of duplicate channels
SELECT 
	channel_name,
	COUNT(*) AS duplicates
FROM 
	view_mex_youtubers
GROUP BY channel_name
HAVING COUNT(*) > 1;


-- Create a new table to export the data to a CSV file
CREATE TABLE mexicans_youtubers AS
	SELECT
		channel_name,
 		total_subscribers, 
 		total_views,
 		total_videos
 	FROM
 		youtube_mx;

-- Review the table
SELECT *
FROM mexicans_youtubers
LIMIT 10;


/*Advertisement campaign analysis
YouTube Channels with the most subscribers
Campaign idea: product placement
Declare the variables using a temporary table*/
DROP TABLE IF EXISTS variables;

CREATE TABLE variables (
    varname text,
    varvalue float
);

-- Adding the values into the temporary table
INSERT INTO variables (varname, varvalue) VALUES 
    ('conversionRate', 0.02),  -- The conversion rate @ 2%
    ('productCost', 5.0),      -- The product cost @ $5
    ('ProductPlacementCost', 50000.0), -- The cost for a product placemente campaign is $50,000
	('SponsoredVideosCost', 55000.0), -- The cost for a sponsored videos campaign is $55,000
	('InfluencerContractCost', 130000.0); -- The cost for a sponsored videos campaign is $55,000

-- Check if the values and variables are correct
SELECT *
FROM variables;
	
/* YouTube Channels with the most subscribers
Campaign idea: product placement
Define the CTE (Common Table Expression) to calculate the rounded average views per video */
WITH ChannelData AS (
    SELECT 
        total_subscribers,
		channel_name,
        total_views,
        total_videos,
        ROUND((total_views::NUMERIC / total_videos), -4) AS avg_views_video
    FROM 
        mexicans_youtubers
)

-- Select and calculate the required fields
SELECT 
    channel_name,
    total_subscribers,
	avg_views_video,
	(avg_views_video * 
		(SELECT varvalue FROM variables WHERE varname = 'conversionRate')) AS potential_units_sold_per_video, 
    (avg_views_video * 
		(SELECT varvalue FROM variables WHERE varname = 'conversionRate') * 
			(SELECT varvalue FROM variables WHERE varname = 'productCost')) AS potential_revenue_per_video,
    ((avg_views_video * (SELECT varvalue FROM variables WHERE varname = 'conversionRate') 
		* (SELECT varvalue FROM variables WHERE varname = 'productCost')) - 
			(SELECT varvalue FROM variables WHERE varname = 'ProductPlacementCost')) AS net_profit
FROM 
    ChannelData
WHERE 
    channel_name IN ('Fede Vigevani', 'YOLO AVENTURAS', 'Badabun') -- Youtubers with the most subscribers 
ORDER BY
    net_profit DESC; -- Order by net profit descending


/* YouTube Channels with the most total views
Campaign idea: sponsored video series
Define the CTE (Common Table Expression) to calculate the rounded average views per video*/
WITH ChannelData AS (
    SELECT 
        total_subscribers,
		channel_name,
        total_views,
        total_videos,
        ROUND((total_views::NUMERIC / total_videos), -4) AS avg_views_video
    FROM 
        mexicans_youtubers
)

-- Select and calculate the required fields
SELECT 
    channel_name,
    total_views,
	avg_views_video,
	(avg_views_video * 
		(SELECT varvalue FROM variables WHERE varname = 'conversionRate')) AS potential_units_sold_per_video, 
    (avg_views_video * 
		(SELECT varvalue FROM variables WHERE varname = 'conversionRate') * 
			(SELECT varvalue FROM variables WHERE varname = 'productCost')) AS potential_revenue_per_video,
    ((avg_views_video * (SELECT varvalue FROM variables WHERE varname = 'conversionRate') 
		* (SELECT varvalue FROM variables WHERE varname = 'productCost')) - 
			(SELECT varvalue FROM variables WHERE varname = 'SponsoredVideosCost')) AS net_profit
FROM 
    ChannelData
WHERE 
    channel_name IN ('YOLO AVENTURAS', 'Masha y el Oso','Badabun') -- Youtubers with the most subscribers 
ORDER BY
    net_profit DESC; -- Order by net profit descending


/*YouTube Channels with the most videos uploaded
Campaign idea: Influencer marketing
Define the CTE (Common Table Expression) to calculate the rounded average views per video */
WITH ChannelData AS (
    SELECT 
        total_subscribers,
		channel_name,
        total_views,
        total_videos,
        ROUND((total_views::NUMERIC / total_videos), -4) AS avg_views_video
    FROM 
        mexicans_youtubers
)

-- Select and calculate the required fields
SELECT 
    channel_name,
    total_videos,
	avg_views_video,
	(avg_views_video * 
		(SELECT varvalue FROM variables WHERE varname = 'conversionRate')) AS potential_units_sold_per_video, 
    (avg_views_video * 
		(SELECT varvalue FROM variables WHERE varname = 'conversionRate') * 
			(SELECT varvalue FROM variables WHERE varname = 'productCost')) AS potential_revenue_per_video,
    ((avg_views_video * (SELECT varvalue FROM variables WHERE varname = 'conversionRate') 
		* (SELECT varvalue FROM variables WHERE varname = 'productCost')) - 
			(SELECT varvalue FROM variables WHERE varname = 'InfluencerContractCost')) AS net_profit
FROM 
    ChannelData
WHERE 
    channel_name IN ('Tlnovelas', 'Badabun', 'Tu COSMOPOLIS') -- Youtubers with the most subscribers 
ORDER BY
    net_profit DESC; -- Order by net profit descending
	
