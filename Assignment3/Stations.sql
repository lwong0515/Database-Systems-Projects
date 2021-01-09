DROP TABLE IF EXISTS CitiBike.Stations;
CREATE TABLE Stations(
	Id INT PRIMARY KEY, 
    Name VARCHAR(255), 
    Latitude DECIMAL(10,8), 
    Longitude DECIMAL(10,8)
);
INSERT INTO CitiBike.Stations
SELECT DISTINCT start_station_id, start_station_name, start_station_latitude, start_station_longitude
FROM CitiBikeData GROUP BY start_station_id
UNION
SELECT DISTINCT end_station_id, end_station_name, end_station_latitude, end_station_longitude
FROM CitiBikeData GROUP BY end_station_id;

SELECT * FROM citibike.stations;