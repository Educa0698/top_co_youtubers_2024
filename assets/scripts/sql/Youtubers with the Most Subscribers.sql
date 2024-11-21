/* 

# 1. Define variables 
# 2. Create a CTE that rounds the average views per video 
# 3. Select the columns you need and create calculated columns from existing ones 
# 4. Filter results by the top 3 YouTube channels with the most subscribers 
# 5. Sort results by net profits (from highest to lowest)

*/

-- 1. 
DECLARE @conversionRate FLOAT = 0.02;          -- The conversion rate @ 2%
DECLARE @productCost FLOAT = 5000.0;          -- The product cost @ $5,000
DECLARE @campaignCost FLOAT = 100000000.0;       -- The campaign cost @ $100,000,000

-- 2.  
WITH ChannelData AS (
    SELECT 
        channel_name,
        total_views,
        total_videos,
        ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
    FROM 
        youtube_db.dbo.view_co_youtubers_2024
)

-- 3. 
SELECT 
    channel_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    ((rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost) AS net_profit
FROM 
    ChannelData

-- 4. 
WHERE 
    channel_name IN (
        SELECT TOP 3 channel_name
        FROM youtube_db.dbo.view_co_youtubers_2024
        ORDER BY total_subscribers DESC
    )

-- 5.  
ORDER BY
    net_profit DESC;


