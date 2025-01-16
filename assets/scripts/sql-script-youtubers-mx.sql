
-- Create de database
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