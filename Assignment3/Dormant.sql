SELECT DISTINCT end_station_id AS "Dormant Station",
end_station_name AS "Dormant Station Name",
end_station_latitude AS "Dormant Station Latitude",
end_station_longitude AS "Dormant Station Longitude"
FROM CitiBikeData
WHERE end_station_id NOT IN (SELECT start_station_id FROM CitiBikeData);