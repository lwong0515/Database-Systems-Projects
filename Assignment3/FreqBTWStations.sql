SET SQL_SAFE_UPDATES=0;
UPDATE CitiBikeData
	SET start_day = WEEKDAY(start_time),
		stop_day = WEEKDAY(stop_time);
SET SQL_SAFE_UPDATES=1;
SELECT DISTINCT
(SELECT start_station_id) AS "Station 1",
(SELECT end_station_id) AS "Station 2",
COUNT(CASE WHEN start_day = 0  THEN bike_id END) AS Number_of_Trips_on_Monday,
COUNT(CASE WHEN start_day = 1  THEN bike_id END) AS "Number of Trips on Tuesday",
COUNT(CASE WHEN start_day = 2  THEN bike_id END) AS "Number of Trips on Wednesday",
COUNT(CASE WHEN start_day = 3  THEN bike_id END) AS "Number of Trips on Thursday",
COUNT(CASE WHEN start_day = 4  THEN bike_id END) AS "Number of Trips on Friday",
COUNT(CASE WHEN start_day = 5  THEN bike_id END) AS "Number of Trips on Saturday",
COUNT(CASE WHEN start_day = 6  THEN bike_id END) AS "Number of Trips on Sunday"
FROM CitiBikeData
GROUP BY start_station_id, end_station_id
ORDER BY Number_of_Trips_on_Monday DESC
-- UNION
-- SELECT DISTINCT
-- (SELECT end_station_id) AS "Station 2",
-- (SELECT start_station_id) AS "Station 1",
-- COUNT(CASE WHEN start_day = 0  THEN bike_id END) AS "Number of Trips on Monday",
-- COUNT(CASE WHEN start_day = 1  THEN bike_id END) AS "Number of Trips on Tuesday",
-- COUNT(CASE WHEN start_day = 2  THEN bike_id END) AS "Number of Trips on Wednesday",
-- COUNT(CASE WHEN start_day = 3  THEN bike_id END) AS "Number of Trips on Thursday",
-- COUNT(CASE WHEN start_day = 4  THEN bike_id END) AS "Number of Trips on Friday",
-- COUNT(CASE WHEN start_day = 5  THEN bike_id END) AS "Number of Trips on Saturday",
-- COUNT(CASE WHEN start_day = 6  THEN bike_id END) AS "Number of Trips on Sunday"
-- FROM CitiBikeData
-- GROUP BY end_station_id, start_station_id