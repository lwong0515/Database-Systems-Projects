DROP TABLE IF EXISTS CitiBike.Trips;
CREATE TABLE Trips(
	StationId INT, 
	MinTripDuration INT, 
	MaxTripDuration INT, 
	AvgTripDuration INT, 
	NumberStartUsers INT,
	NumberReturnUsers INT,
	FOREIGN KEY(StationId) REFERENCES Stations(Id)
);
INSERT INTO CitiBike.Trips
SELECT S.StationId, S.MinTripDuration, S.MaxTripDuration, S.AvgTripDuration, S.NumberStartUsers, E.NumberReturnUsers
FROM
(SELECT DISTINCT start_station_id AS StationId, 
	MIN(trip_duration) AS MinTripDuration, 
	MAX(trip_duration) AS MaxTripDuration , 
	FLOOR(AVG(trip_duration)) AS AvgTripDuration, 
	COUNT(bike_id) AS NumberStartUsers 
	FROM CitiBikeData 
	GROUP BY start_station_id
	ORDER BY start_station_id) S
INNER JOIN
(SELECT DISTINCT end_station_id AS StationId, 
	COUNT(bike_id) AS NumberReturnUsers 
	FROM CitiBikeData 
	GROUP BY end_station_id
	ORDER BY end_station_id) E
ON S.StationId = E.StationId;
SELECT * FROM citibike.trips;
