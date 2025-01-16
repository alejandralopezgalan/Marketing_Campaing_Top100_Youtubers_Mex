# Importing necessary libraries
import os
import pandas as pd
from dotenv import load_dotenv
from googleapiclient.discovery import build

# Load environment variables from a .env file
load_dotenv() 

# Define YouTube API key and version
API_KEY = '' # Put your Google API key here
API_VERSION = 'v3'

# Build the YouTube API client
youtube = build('youtube', API_VERSION, developerKey=API_KEY)

# Function to get the number of subscribers, views, and videos of each channel
def get_channel_stats(youtube, channel_id):
    # Create a request to get channel statistics
    request = youtube.channels().list(
        part='snippet, statistics',
        id=channel_id
    )
    # Execute the request and get the response
    response = request.execute()
    # Check if the response contains data
    if 'items' in response and response['items']:
        # Extract the relevant data from the response
        data = dict(channel_name=response['items'][0]['snippet']['title'],
                    total_subscribers=response['items'][0]['statistics']['subscriberCount'],
                    total_views=response['items'][0]['statistics']['viewCount'],
                    total_videos=response['items'][0]['statistics']['videoCount'],
        )
        return data
    else:
        print(f"No data found for channel ID: {channel_id}") 
        return None

# Example channel ID to test the function
channel_id = "UC9LQwHZoucFT94I2h6JOcjw"
print(get_channel_stats(youtube, channel_id))

# Read CSV file into a dataframe
df = pd.read_csv("youtube_data_mexico.csv")

# Extract channel IDs from the dataframe and remove potential duplicates
channel_ids = df['NAME'].str.split('@').str[-1].unique()

# Initialise a list to store channel statistics
channel_stats = []

# Loop over the channel IDs and get stats for each channel
for channel_id in channel_ids:
    stats = get_channel_stats(youtube, channel_id)
    if stats is not None:
        channel_stats.append(stats)

# Convert the list of channel stats to a dataframe
stats_df = pd.DataFrame(channel_stats)

# Reset index for consistency
df.reset_index(drop=True, inplace=True)
stats_df.reset_index(drop=True, inplace=True)

# Concatenate the original dataframe with the stats dataframe horizontally
combined_df = pd.concat([df, stats_df], axis=1)

# Optionally, drop the 'channel_name' column from stats_df (since 'NAME' already exists in the original dataframe) 
# # I preferred to keep it to review any discrepancies or missing data 
# # combined_df.drop('channel_name', axis=1, inplace=True)

# Save the merged dataframe back into a CSV file
combined_df.to_csv('updated_youtube_data_mex.csv', index=False)

# Display the first 10 rows of the combined dataframe
combined_df.head(10)