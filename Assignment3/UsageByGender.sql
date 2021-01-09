DROP TABLE IF EXISTS CitiBike.UsageByGender;
CREATE TABLE UsageByGender(
	StationId INT, 
    NumberMaleStartUsers INT, 
    NumberFemaleStartUsers INT,
	NumberMaleReturnUsers INT, 
    NumberFemaleReturnUsers INT,
	FOREIGN KEY(StationId) REFERENCES Stations(Id)
);
INSERT INTO CitiBike.UsageByGender
SELECT S.StationId, S.NumberMaleStartUsers, S.NumberFemaleStartUsers,
	   E.NumberMaleReturnUsers, E.NumberFemaleReturnUsers
FROM
(SELECT DISTINCT start_station_id AS StationId, 
	COUNT(CASE WHEN gender = 1 THEN bike_id END) AS NumberMaleStartUsers,
    COUNT(CASE WHEN gender = 2 THEN bike_id END) AS NumberFemaleStartUsers
	FROM CitiBikeData 
    GROUP BY start_station_id 
    ORDER BY start_station_id) S
INNER JOIN
(SELECT DISTINCT end_station_id AS StationId, 
	COUNT(CASE WHEN gender = 1 THEN bike_id END) AS NumberMaleReturnUsers,
    COUNT(CASE WHEN gender = 2 THEN bike_id END) AS NumberFemaleReturnUsers
    FROM CitiBikeData 
    GROUP BY end_station_id 
    ORDER BY end_station_id) E
ON S.StationId = E.StationId;
SELECT * FROM citibike.usagebygender;