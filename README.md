# Top 100 YouTubers from Mexico
**A data portfolio project using Excel, PostgreSQL, and Power BI to analyse the top 100 YouTubers from Mexico**

<img src="assets/img/project2_portada_influencer.png" width="500" height="600" />

Image from [storyset](https://storyset.com/search?q=video%20influencer)

> **Note**
>
> This project was inspired and guided by the work of Stephen David William [GitHub](https://github.com/sdw-online), whose data portfolio project provided invaluable insights and direction. I deeply appreciate the effort and dedication Stephen put into creating such a comprehensive resource.
>
> Original Project:
> 
> Title: Excel to Power BI Portfolio Project | Full End-to-End Data Project | top_uk_youtubers_2024. Author: Stephen David William. Platform: [YouTube](https://www.youtube.com/watch?v=mm_sN-Elplg&t=510s&ab_channel=Stephen%7CData)
>
> I have used this project as a foundation to expand my skills and knowledge in data analytics. All credit for the original concept and methodology goes to [Stephen David William](https://www.linkedin.com/in/stephen-david-williams-860428123/).
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
   - [Data Transformation](#data-transformation)
   - [DAX measures](#dax-measures)
   - [Data Analysis](#data-analysis)
   - [Data Visualisation](#data-visualisation)
- [Results and Implications](#results-and-implications)

---
## Executive Summary
### Primary Goal
Identify the top YouTubers from Mexico in 2024 to determine which influencers would be best suited for running successful marketing campaigns throughout the rest of the year.

### Solution
Develop a dashboard to offer insights into the top Mexican YouTubers in 2024, showcasing their **subscriber count, total views, total videos**, and **engagement metrics**. This tool will support the marketing team in making informed decisions about which YouTubers to collaborate with for their campaigns


### Key Findings
-
-
-

### Recommendations
-
-
-

---

## Introduction

### Business Problem
The marketing team needs to identify and collaborate with the most influential Mexican YouTubers to maximise the effectiveness of their marketing campaigns. Currently, they lack a comprehensive and easily accessible tool that provides insights into key metrics such as subscriber count, total views, total videos, and engagement metrics. This gap hinders their ability to make informed decisions about which YouTubers to partner with for optimal campaign performance

### Goals
1. Develop an Interactive Dashboard: Create a user-friendly dashboard using Power BI to visualise data on the top Mexican YouTubers in 2024.
2. Data Collection and Integration: Gather comprehensive data on subscriber counts, total views, total videos, and engagement metrics for the top YouTubers in Mexico.
3. Insight Generation: Analyse the collected data to identify trends and patterns among the top YouTubers.
4. Support Informed Decision-Making: Equip the marketing team with actionable insights to identify the best YouTubers for collaboration. 
5. Customisable Features: Allow for customisable views and filters within the dashboard to cater to specific needs and preferences of the marketing team.

---
## Methodology

### Data source

The dataset is sourced from [Kaggle](https://www.kaggle.com/datasets/bhavyadhingra00020/top-100-social-media-influencers-2024-countrywise?resource=download). To view the CSV file, click [here](assets/data/youtube_data_mexico.csv).

This dataset provides structured information about the top 100 YouTubers from Mexico in 2024. Each entry represents a YouTuber and includes the following attributes:

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
Displayed below is a screenshot of a portion of the data presented in Excel
![Screenshot_data](assets/img/project2_kaggle_data_original.png)

The objective is to refine our dataset, ensuring it is well-structured and primed for analysis.

Criteria for the cleaned data:
- Retain only the columns that are pertinent.
- Ensure all data types are suitable for their respective columns.
- Verify that no column contains null values, guaranteeing completeness of all records.

After the initial data exploration, I realised that some columns, such as ER, COUNTRY, and TOPIC OF INFLUENCE, are either irrelevant for our analysis or have missing values. Considering our primary goal and the desired solution, the dataset should contain information related to subscriber count, total views, total videos, and engagement metrics. Therefore, we need to extract this information from YouTube to complement our dataset. I use a Python script to extract that information from YouTube.

### Extracting data from YouTube
I implemented a Python script based on the script developed by Stephen David William [GitHub]([https://github.com/sdw-online](https://github.com/sdw-online/top_uk_youtubers_2024). To see the script I used, just click [here](assets/script/script_youtube_python.py). 

After runing the script, the dataset has now four additional columns: `channel_name`,	`total_subscribers`,	`total_views` and `total_videos` as seen in the following image. However, the script did not extracted data from two Yotubers, which could be related to not recognising the channel ID.
![updated_data](assets/img/project2_data_updated.png)

The script output found no data on these two channels, but they actually exist on YouTube. Therefore, I decided to manually enter this data using the information from ABout section of these Youtube channels. I added this information at the end of the table, as I could Excel to sort the channels on their respecting rank, based on the	`total_subscribers`,	`total_views` and `total_videos` later on.
![script_ouput](assets/img/project2_script_output.png)


