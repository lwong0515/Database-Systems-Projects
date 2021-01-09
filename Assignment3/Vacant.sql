SELECT DISTINCT start_station_id AS 'Vacant Station',
start_station_name AS "Vacant Station Name",
start_station_latitude AS "Vacant Station Latitude",
start_station_longitude AS "Vacant Station Longitude"
FROM CitiBikeData
WHERE start_station_id NOT IN (SELECT end_station_id FROM CitiBikeData);



