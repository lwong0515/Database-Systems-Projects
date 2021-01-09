DROP DATABASE IF EXISTS CitiBike;
CREATE DATABASE CitiBike;  
USE CitiBike;

/* Temporary Table Containing All Data*/
CREATE TABLE CitiBikeData(
	trip_duration INT,
    start_time TIMESTAMP,
    start_day VARCHAR(9),
    stop_time TIMESTAMP,
    stop_day VARCHAR(9),
    start_station_id INT,
    start_station_name VARCHAR(255),
    start_station_latitude DECIMAL(10,8),
    start_station_longitude DECIMAL(10,8),
    end_station_id INT,
    end_station_name VARCHAR(255),
    end_station_latitude DECIMAL(10,8),
    end_station_longitude DECIMAL(10,8),
    bike_id INT,
    usertype ENUM("Subscriber","Customer"),
    birth_year SMALLINT,
    gender INT 
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data_set.csv'
INTO TABLE CitiBikeData
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(trip_duration, @start_timee, start_day, @stop_time, stop_day, start_station_id, start_station_name,
start_station_latitude, start_station_longitude, end_station_id, end_station_name,
end_station_latitude, end_station_longitude, bike_id, usertype, birth_year, gender)
SET
start_time = STR_TO_DATE(@start_timee, "%m/%d/%Y %H:%i %r"),
stop_time = STR_TO_DATE(@stop_time, "%m/%d/%Y %H:%i %r"),
-- trip_duration = TIMESTAMPDIFF(second, start_time, stop_time), --trip_duration dependent on start_time and end_time (but record times aren't precise enough)
start_day = DAYNAME(start_time),
stop_day = DAYNAME(stop_time);

-- DROP TABLE IF EXISTS CitiBike.Stations;
-- CREATE TABLE Stations(
-- 	Id INT PRIMARY KEY, 
--     Name VARCHAR(255), 
--     Latitude DECIMAL(10,8), 
--     Longitude DECIMAL(10,8)
-- );
-- INSERT INTO CitiBike.Stations
-- SELECT start_station_id, start_station_name, start_station_latitude, start_station_longitude
-- FROM CitiBikeData GROUP BY start_station_id 
-- UNION
-- SELECT end_station_id, end_station_name, end_station_latitude, end_station_longitude
-- FROM CitiBikeData GROUP BY end_station_id

SELECT * FROM citibike.citibikedata;