# Top 100 YouTubers from Mexico
**A data portfolio project using Excel, PostgreSQL, and Power BI to analyse the top 100 YouTubers from Mexico**

<img src="assets/img/project2_portada_influencer.png" width="500" height="600" />

Image from [storyset](https://storyset.com/search?q=video%20influencer)

> **Note**
>
> This project was inspired and guided by the work of Stephen David William on [GitHub](https://github.com/sdw-online), wwhose data portfolio project provided invaluable insights and direction. I deeply appreciate the effort and dedication Stephen put into creating such a comprehensive resource.
>
> Original Project:
> 
> Title: Excel to Power BI Portfolio Project | Full End-to-End Data Project | top_uk_youtubers_2024. Author: Stephen David William. Platform: [YouTube](https://www.youtube.com/watch?v=mm_sN-Elplg&t=510s&ab_channel=Stephen%7CData)
>
> I have used this project as a foundation to expand my skills and knowledge in data analytics. All credit for the original concept and methodology goes to[Stephen David William](https://www.linkedin.com/in/stephen-david-williams-860428123/).
<br/>

## Table Of Contents
- [Executive Summary](#executive-summary)
  - [Primary Goal](#primary-goal)
  - [Solution](#solution)
  - [Key Findings](#key-findings)
  - [Recommendations](#recommendations)
- [Introduction](#introduction)
  - [Business Problem](#business-problem)
  - [Goals](#goals)
- [Methodology](#methodology)
  - [Data Source](#data-source)
  - [Tools](#tools)
  - [Data Cleaning](#data-cleaning)
  - [Extracting data from YouTube](extracting-data-from-youtube)
  - [Data Transformation in SQL](#data-transformation-in-sql)
  - [Analysis in Power BI](#analysis-in-power-bi)
    - [DAX measures](#dax-measures)
    - [Data Visualisation](#data-visualisation)
  - [Data Analysis for the Marketing Campaign](#data-analysis-for-the-marketing-campaign)
    - [YouTubers with the most subscribers](#youtubers-with-the-most-subscribers)
    - [YouTubers with the most total views](#youtubers-with-the-most-total-views)
    - [YouTubers with the most videos uploaded](#youtubers-with-the-most-videos-uploaded)
- [Insights](#insights)
    - [Potential Return on Investment](#potential-return-on-investment)
	 


---
## Executive Summary
### Primary Goal
Identify the top YouTubers from Mexico in 2024 to determine which influencers are best suited for running successful marketing campaigns throughout the rest of the year.

### Solution
Develop a dashboard to provide insights into the top Mexican YouTubers in 2024, showcasing their **subscriber count, total views, total videos**, and **engagement metrics**. This tool will support the marketing team in making informed decisions about which YouTubers to collaborate with for their campaigns.


### Key Findings
- 
- a
-

### Recommendations
-
-
-

---

## Introduction

### Business Problem
The marketing team needs to identify and collaborate with the most influential Mexican YouTubers to maximise the effectiveness of their marketing campaigns. Currently, they lack a comprehensive and easily accessible tool that provides insights into key metrics such as subscriber count, total views, total videos, and engagement metrics. This gap hinders their ability to make informed decisions about which YouTubers to partner with for optimal campaign performance.

### Goals
1. Develop an Interactive Dashboard: Create a user-friendly dashboard using Power BI to visualise data on the top Mexican YouTubers in 2024.
2. Data Collection and Integration: Gather comprehensive data on subscriber counts, total views, total videos, and engagement metrics for the top YouTubers in Mexico.
3. Insight Generation: Analyse the collected data to identify trends and patterns among the top YouTubers.
4. Support Informed Decision-Making: Equip the marketing team with actionable insights to identify the best YouTubers for collaboration.
5. Customisable Features: Allow for customisable views and filters within the dashboard to cater to the specific needs and preferences of the marketing team.

---
## Methodology

### Data source

The dataset is sourced from [Kaggle](https://www.kaggle.com/datasets/bhavyadhingra00020/top-100-social-media-influencers-2024-countrywise?resource=download). To view the CSV file, click [here](assets/data/youtube_data_mexico.csv).

his dataset provides structured information about the top 100 YouTubers from Mexico in 2024. Each entry represents a YouTuber and includes the following attributes:

| Column name | Description | 
| :--- | :--- |
| `#` | The ranking of the YouTuber in the top 100 list |
| `NAME` | The name or pseudonym of the YouTuber |
| `FOLLOWERS` | The total number of subscribers the influencer has on YouTube |
| `ER` | Engagement Rate: The level of interaction that the influencer's content receives from users on social media platforms, expressed as a percentage |
| `COUNTRY` | The geographical location or country where the YouTuber is based or primarily operates |
| `TOPIC OF INFLUENCE` | The niche or category in which the YouTuber specialises or creates content, such as fashion, beauty, technology, fitness, etc. |
| `POTENTIAL REACH` | TThe estimated number of people who could see a YouTube video or campaign from this influencer |

### Tools
- Excel: To explore the data
- PostgreSQL: To clean, test, and analyse the data
- Power BI: To visualise the data via interactive dashboards
- GitHub: To host the project documentation and version control

### Data Cleaning
Displayed below is a screenshot of a portion of the data presented in Excel.

![Screenshot_data](assets/img/project2_kaggle_data_original.png)

The objective is to refine our dataset, ensuring it is well-structured and primed for analysis.

Criteria for the cleaned data:
- Retain only the columns that are pertinent.
- Ensure all data types are suitable for their respective columns.
- Verify that no column contains null values, guaranteeing completeness of all records.

After the initial data exploration, I realised that some columns, such as `ER`, `COUNTRY`, and `TOPIC OF INFLUENCE`, are either irrelevant for our analysis or have missing values. Considering our primary goal and the desired solution, the dataset should contain information related to subscriber count, total views, total videos, and engagement metrics. Therefore, I needed to extract this information from YouTube to complement our dataset. I used a Python script to extract that information from YouTube.

### Extracting data from YouTube
I implemented a Python script based on the script developed by Stephen David William, available on [GitHub]([https://github.com/sdw-online](https://github.com/sdw-online/top_uk_youtubers_2024). To see the script I used, just click [here](assets/script/script_youtube_python.py). 

After running the script, the dataset included four additional columns: `channel_name`,	`total_subscribers`,	`total_views` and `total_videos`as seen in the following image. However, the script did not extract data from two YouTubers, possibly due to unrecognised channel IDs.

![updated_data](assets/img/project2_data_updated.png)

The script output found no data on these two channels, even though they actually exist on YouTube. Therefore, I decided to manually enter this data using the information from the 'About' section of these YouTube channels. I added this information at the end of the table, so I could use Excel or SQL to sort the channels by their respective ranks based on	`total_subscribers`,	`total_views` and `total_videos` later on. 

![script_ouput](assets/img/project2_script_output.png)

For the following steps, I used PostgreSQL. I changed the column names to lowercase with dashes instead of spaces and renamed the column `rank` instead of `#`in Excel before loading the data into SQL. The updated dataset can be found [here](assets/data/updated_youtube_data_mex.csv) and the following image shows a view of this dataset 

![for-sql](/assets/img/project2_database_for_sql.png)

### Data Transformation in SQL
I developed a SQL script for data cleaning. For a detailed review of the script, click [here](assets/scripts/sql-script-youtubers-mx.sql). The steps involved in the scripts were:
1. Create the database.
2. Create the table to store YouTube data.
3. Import the data into the newly created table and verify proper loading.
4. Create a view to simplify the data by selecting specific columns: `channel_name`,	`total_subscribers`,	`total_views` and `total_videos`.
5. Perform data quality checks:
   - a. Verify the number of rows: Top 100 YouTube channels.
   - b. Verify the number of columns: `channel_name`,	`total_subscribers`,	`total_views` and `total_videos`
   - c. Check the data type of each variable.
   - d. Check the number of unique channels in the database or count the number of duplicate channels.
6. Create a new table to export the data to a CSV file. To see the output file, click this [link](assets/data/mx_youtubers_data2024.csv).

<img src="assets/img/project2_database_view_sql.png" width="550" height="500" />

**SQL code** 
```sql  
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

/* However, since the channel_name is already correctly formatted from the Python script, 
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
   ```  


### Analysis in Power BI
I loaded the CSV file [mx_youtubers_data2024](assets/data/mx_youtubers_data2024.csv) into a Power BI report, and the following image showed that the variables were correctly loaded.

![loaded_data_powerbi](assets/img/prject2_data_loaded-powerbi.png)

#### DAX measures
I constructed a table with all the essential measures for the analysis, employing DAX formulas to develop these metrics.

**1. `AvgViewsPerVideo(M)`** <br />
Computes the average number of views per video, expressed in millions, for a YouTube channel.
```sql  
AvgViewsPerVideo(M) =
  VAR sumtotalviews = SUM(mx_youtubers_data2024[total_views])
  VAR sumofvideos = SUM(mx_youtubers_data2024[total_videos])
  VAR avgviewspervideo = DIVIDE(sumtotalviews, sumofvideos, BLANK())
  VAR avgviewspervideomillions = DIVIDE(avgviewspervideo, 1000000, BLANK())

  RETURN avgviewspervideomillions
```
<br />

**2. `SubscriberEngagementRate`** <br />
Calculates the average number of subscribers per video for a YouTube channel.
```sql  
SubscriberEngagementRate =
  VAR sumtotalsubscribers = SUM(mx_youtubers_data2024[total_subscribers])
  VAR sumtotalvideos = SUM(mx_youtubers_data2024[total_videos])
  VAR subscribersengrate = DIVIDE(sumtotalsubscribers, sumtotalvideos, BLANK())

  RETURN subscribersengrate
```
<br />

**3. `TotalSubscribers(M)`** <br />
Converts the total number of subscribers into millions, making it easier to interpret large subscriber counts.
```sql  
TotalSubscribers(M) =
  VAR million = 1000000
  VAR sumofsubscribers = SUM(mx_youtubers_data2024[total_subscribers])
  VAR totalsubscribers = DIVIDE(sumofsubscribers, million)

  RETURN totalsubscribers
```
<br />

**4. `TotalVideos`** <br />
Sums up the total number of videos for a YouTube channel.
```sql  
TotalVideos =
  VAR totalvideos = SUM(mx_youtubers_data2024[total_videos])

  RETURN totalvideos
```
<br />

**5. `TotalViews(B)`** <br />
Converts the total number of views into billions, providing a clearer representation of large view counts.
```sql  
TotalViews(B) =
  VAR billion = 1000000000
  VAR sumoftotalviews = SUM(mx_youtubers_data2024[total_views])
  VAR totalviews = DIVIDE(sumoftotalviews, billion, BLANK())

  RETURN totalviews
```
<br />

**6. `ViewsPerSubscriber`** <br />
Determines the total number of views each subscriber has generated, offering insights into how engaged the subscriber base is with the channel's content.
```sql  
ViewsPerSubscriber =
  VAR sumtotalsubscribers = SUM(mx_youtubers_data2024[total_subscribers])
  VAR sumofviews = SUM(mx_youtubers_data2024[total_views])
  VAR viewspersubscriber = DIVIDE(sumofviews, sumtotalsubscribers, BLANK())

  RETURN viewspersubscriber
```


#### Data Visualisation

The dashboard consist of: 
1. Table of the Top 100 YouTubers: This table presents the most popular YouTube influencers, showcasing data on their total number of subscribers (in millions), the aggregate number of videos, and the overall views (in billions).
2. Treemap of the Top 10 YouTubers: This treemap illustrates the top 10 YouTubers by their total views (in billions). Each segment delineates a YouTuber, accompanied by data on their total number of videos and subscribers (in millions).
3. Channel Engagement Ratios: Three cards present essential engagement metrics.
   - Average Views per Video: The mean number of views each video generates.
   - Subscriber Engagement Rate: A metric quantifying the extent of subscribers' engagement with the content.
   - Views per Subscriber: The average number of views generated per subscriber.
4. Bar Chart of the Top 10 YouTubers: This bar chart ranks the top 10 YouTubers based on their total number of subscribers (in millions), providing a visual representation of their popularity.

![dashboard](assets/img/project2_dashboard.png)

The interactive features of this dashboard:
1. Table Interactivity: The table facilitates sorting and filtering of the top 100 YouTubers by subscribers, videos, or views. Selecting a YouTuber's name could present detailed insights into their channel's performance.
2. Treemap Interactivity: Hovering over each segment of the treemap unveils additional information regarding the YouTuber's total videos and subscribers. Selecting a segment could navigate to a more detailed analysis of that YouTuber's channel analytics.
3. Engagement Cards Interactivity: The cards dynamically update as different YouTubers are selected from the table or treemap, enabling the comparison of engagement metrics across channels.
4. Bar Chart Interactivity: The bar chart permits highlighting and comparison of the top 10 YouTubers by total subscribers. Hovering over each bar displays a tooltip with more comprehensive subscriber information.

![dashboard-video](assets/img/project2_video_dashboard.gif)

### Data Analysis for the Marketing Campaign
Based on the information and the data analysis I have done so far, it is possible to continue with the marketing analysis for the campaign. First, I focused on the following questions:

1. Who are the top 10 YouTubers with the most subscribers?

| Rank | Channel                                            | Subscribers (M) |
| :--- |:-------------------------------------------------- | --------------: |
| 1    | Fede Vigevani                                      | 62.30           |
| 2    | YOLO AVENTURAS                                     | 58.50           |
| 3    | Badabun                                            | 47.60           |
| 4    | Kimberly Loaiza                                    | 46.30           |
| 5    | Juan De Dios Pantoja                               | 44.00           |
| 6    | Masha y el Oso                                     | 39.60           |
| 7    | GENIAL                                             | 32.00           |
| 8    | YOLO                                               | 31.90           |
| 9    | Susy Mouriz                                        | 27.30           |
| 10   | BabyBus - Canciones Infantiles & Videos para Niños | 26.80           |
<br />

2. Which 3 channels have uploaded the most videos?

| Rank | Channel       | Videos Uploaded |
| :--- |:------------- | --------------: |
| 1    | Tlnovelas     | 59898           |
| 2    | Badabun       | 24080           |
| 3    | Tu COSMOPOLIS | 11926           |
<br />

3. Which 3 channels have the most views?

| Rank | Channel        | Total Views (B) |
| :--- |:-------------- | --------------: |
| 1    | YOLO AVENTURAS | 20.52           |
| 2    | Masha y el Oso | 20.26           |
| 3    | Badabun        | 19.91           |
<br />

4. Which 3 channels have the highest average views per video?

| Rank | Channel               | Average Views per Video (M) |
| :--- |:--------------------- | --------------------------: |
| 1    | Christian Nodal       | 564.02                      |
| 2    | Los Ángeles Azules    | 116.24                      |
| 3    | vicentefernandez&reg; | 87.58                       |
<br />

5. Which 3 channels have the highest views per subscriber ratio?

| Rank | Channel               | Views per Subscriber |
| :--- |:--------------------- | -------------------: |
| 1    | Los Ángeles Azules    | 1,490.62             |
| 2    | Lizos Music           | 1,433.94             |
| 3    | vicentefernandez&reg; | 1,316.36             |
<br />
   
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?

| Rank | Channel            | Subscriber Engagement Rate |
| :--- |:------------------ | -------------------------: |
| 1    | Kenia Os           | 1,203,333.33               |
| 2    | Christian Nodal    | 610,526.32                 |
| 3    | MrBeast en Español | 394,029.85                 |

For this analysis, it is best to prioritise the metrics that are crucial in generating the expected ROI for our marketing team. These metrics are:
- Top 3 YouTube channels with the most subscribers
- Top 3 YouTube channels with the most total views
- Top 3 YouTube channels with the most videos uploaded

In the advertisement analysis, the marketing team set a Conversion Rate of 2%, which indicates the proportion of viewers who act after watching the ad on a YouTube video. They also defined a product cost of $5.00 and allocated a campaign budget of $50,000 to compensate the YouTuber.


#### YouTubers with the most subscribers
I calculated the `Potential Product Sales per Video` by multiplying the `Average Views per Video` by the `Conversion Rate`. Then, I multiplied the `Potential Product Sales per Video` by the `Product Cost` to calculate the `Potential Revenue per Video`. Finally the `Net Profit`was the difference between the `Potential Revenue per Video` and the `Campaign Cost`. 

**Campaign idea: product placement**
- `Conversion Rate` = 2.00%
- `Product Cost` = $5.00
- `Product Placement Campaign Cost` = $50,000

| Rank | Channel | Total Subscribers | Average Views per Video (M) | Potential Units Sold per Video | Potential Revenue per Video | Net Profit |
| :--- |:------- | --------: | -------:| --------:| -----------:| ----------:| 
| 1 | Fede Vigevani | 62,300,000 | 12,710,000 | 254,200 | 1,271,000 | 1,221,000 |
| 2 | YOLO AVENTURAS | 58,500,000 | 7,600,000 | 152,000 | 760,000 | 710,000    |
| 3 | Badabun | 47,600,000 | 830,000 | 16,600 | 83,000 | 33,000 |

**SQL code**
```sql  
-- Advertisement campaign analysis
-- YouTube Channels with the most subscribers
-- Campaign idea: product placement
-- Declare the variables using a temporary table
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
	('InfluencerContractCost', 55000.0); -- The cost for a sponsored videos campaign is $55,000


-- Check if the values and variables are correct
SELECT *
FROM variables;
	

-- Define the CTE (Common Table Expression) to calculate the rounded average views per video
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

```

#### YouTubers with the most total views
Using a similar approach, I calculated the variables for the YouTube channels with most total views

**Campaign idea: sponsored video series**
- `Conversion Rate` = 2.00%
- `Product Cost` = $5.00
- `Sponsored Videos Cost` 11 videos at $5,000 each = $55,000

| Rank | Channel | Total Views | Average Views per Video (M) | Potential Units Sold per Video | Potential Revenue per Video | Net Profit |
| :--- |:--------- | --------: | ------------:| --------------:| ----------:| -------:| 
| 1 | Masha y el Oso | 20,262,996,461 | 12,160,000 | 243,200 | 1,216,000 | 1,161,000 |
| 2 | YOLO AVENTURAS | 20,524,794,143 | 7,600,000 | 152,000 | 760,000 | 705,000 |
| 3 | Badabun | 19,911,915,821 | 830,000 | 16,600 | 83,000 | 28,000 |

**SQL code**

#### YouTubers with the most videos uploaded
Finally, the results for the YouTube channels with the most videos uploaded were:

**Campaign idea: Influencer marketing**
- `Conversion Rate` = 2.00%
- `Product Cost` = $5.00
- `Influencer Marketing Cost` (3 Month Contract) = $130,000

| Rank | Channel | Total Videos | Average Views per Video (M) | Potential Units Sold per Video | Potential Revenue per Video | Net Profit |
| :--- |:------ | ----: | -------:| -----------:| ----------:| ----------:| 
| 1 | Badabun | 24,080 | 830,000 | 16,600 | 83,000 | -47,000 |
| 2 | Tu COSMOPOLIS | 11,926 | 440,000 | 8,800 | 44,000 | -86,000 |
| 3 | Tlnovelas | 59,898 | 320,000 | 6,400 | 32,000 | -98,000 |

**SQL code**

## Insights
The YouTube landscape in Mexico is dominated by a variety of popular channels, each excelling in different aspects. Fede Vigevani, YOLO AVENTURAS, and Badabun are the channels with the highest number of subscribers, alluring a vast audience with their engaging content. 

When it comes to the volume of videos uploaded, Badabun leads, followed by Tlnovelas and Tu COSMOPOLIS, showcasing their dedication to consistently providing fresh content. Meanwhile, channels like Masha y el Oso, YOLO AVENTURAS, and Badabun are celebrated for their popularity and video views, demonstrating their widespread influence in the region. This mix of channels highlights the diverse tastes and preferences of the Mexican YouTube audience.

Fede Vigevani is the best YouTube channel to collaborate with if we want to maximise visbility because this channel has the most YouTube subscribers in Mexico and the higest average views per video. Although Badabun, Tu COSMOPOLIS, and Tlnovelas are regular publishers on YouTube, it may be worth considering whether collaborating with them with the current budget caps are worth the effort, as the potential return on investments is significantly lower and even negative compared to the other channels.

The top 3 channels to form collaborations with are Fede Vigevani, Masha y el Oso, and YOLO AVENTURAS based on this analysis, because they attract the most engagement on their channels consistently.

### Potential Return on Investment
- Setting up a collaboration deal with Fede Vigevani would make a net profit of $1,221,000 per video. 
- An influencer marketing contract with Masha y el Oso can generate a net profit of $1,166,000 per video.
- A product placement campaign with YOLO AVENTURAS could generate approximately $710,000 per video. 
NoCopyrightSounds could profit the client $642,000 per video too (which is worth considering)

## Conclusions
