DROP TABLE IF EXISTS CitiBike.UsageByDay;
CREATE TABLE UsageByDay(
	StationId INT, 
    NumberWeekdayStartUsers INT, 
    NumberWeekdayReturnUsers INT,
	NumberWeekendStartUsers INT, 
    NumberWeekendReturnUsers INT,
    FOREIGN KEY(StationId) REFERENCES Stations(Id)
);
SET SQL_SAFE_UPDATES=0;
UPDATE CitiBikeData
	SET start_day = WEEKDAY(start_time),
		stop_day = WEEKDAY(stop_time);
SET SQL_SAFE_UPDATES=1;
INSERT INTO CitiBike.UsageByDay
SELECT S.StationId, S.NumberWeekdayStartUsers, S.NumberWeekendStartUsers,
	   E.NumberWeekdayReturnUsers, E.NumberWeekendReturnUsers
FROM
(SELECT DISTINCT start_station_id AS StationId, 
	COUNT(CASE WHEN start_day < 5  THEN bike_id END) AS NumberWeekdayStartUsers,
    COUNT(CASE WHEN start_day >= 5  THEN bike_id END) AS NumberWeekendStartUsers
	FROM CitiBikeData 
    GROUP BY start_station_id
    ORDER BY start_station_id) S
INNER JOIN
(SELECT DISTINCT end_station_id AS StationId, 
	COUNT(CASE WHEN stop_day < 5 THEN bike_id END) AS NumberWeekdayReturnUsers,
    COUNT(CASE WHEN stop_day >= 5 THEN bike_id END) AS NumberWeekendReturnUsers 
    FROM CitiBikeData 
    GROUP BY end_station_id
    ORDER BY end_station_id) E
ON S.StationId = E.StationId;
SELECT * FROM citibike.usagebyday;
