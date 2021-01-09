DROP TABLE IF EXISTS CitiBike.UsageByAge;
CREATE TABLE UsageByAge(
	StationId INT, 
    NumberMaleUsersUnder18 INT, 
    NumberMaleUsers18To40 INT,
	NumberMaleUsersOver40 INT, 
    NumberFemaleUsersUnder18 INT,
	NumberFemaleUsers18To40 INT,
    NumberFemaleUsersOver40 INT,
    FOREIGN KEY(StationId) REFERENCES Stations(Id)
);
SET @RECORDYEAR = 2013;
INSERT INTO CitiBike.UsageByAge
SELECT DISTINCT start_station_id AS StationId,
COUNT(CASE WHEN gender = 1 AND (@RECORDYEAR - birth_year < 18) THEN bike_id END) AS NumberMaleStartUsers,
COUNT(CASE WHEN gender = 1 AND (@RECORDYEAR - birth_year >= 18 AND  @RECORDYEAR - birth_year <= 40) THEN bike_id END) AS NumberMaleUsers18To40,
COUNT(CASE WHEN gender = 1 AND (@RECORDYEAR - birth_year > 40) THEN bike_id END) AS NumberMaleUsersOver40,
COUNT(CASE WHEN gender = 2 AND (@RECORDYEAR - birth_year < 18) THEN bike_id END) AS NumberFemaleStartUsers,
COUNT(CASE WHEN gender = 2 AND (@RECORDYEAR - birth_year >= 18 AND  @RECORDYEAR - birth_year <= 40) THEN bike_id END) AS NumberFemaleUsers18To40,
COUNT(CASE WHEN gender = 2 AND (@RECORDYEAR - birth_year > 40) THEN bike_id END) AS NumberFemaleUsersOver40
FROM CitiBikeData 
GROUP BY start_station_id 
ORDER BY start_station_id;
SELECT * FROM citibike.usagebyage;
