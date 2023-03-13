SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE
 '/Users/mihailkalinin/учеба/Институт ПС/data_bases/lw2/station.csv'
 INTO TABLE station_data
 FIELDS TERMINATED BY ',' ENCLOSED BY '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 LINES;

INSERT INTO position (position)
	SELECT DISTINCT
		station_relative_position
	FROM station_data;

SET SQL_SAFE_UPDATES = 0; -- отключение safe update т.к. в station_data нет первичного ключа
UPDATE station_data SET highway_name = REPLACE(highway_name, 'Кучки-Кучкинское лесничество', 'Кучки - Кучкинское лесничество') WHERE highway_name LIKE "%";
UPDATE station_data SET highway_name = REPLACE(highway_name, 'Великополье-Зеленый', 'Великополье - Зеленый') WHERE highway_name LIKE "%";
UPDATE station_data SET highway_name = REPLACE(highway_name, 'Михайловка-Большеникольск', 'Михайловка - Большеникольск') WHERE highway_name LIKE "%";
UPDATE station_data SET highway_name = REPLACE(highway_name, 'Мананмучаш-Кельмаксола-Лайсола', 'Мананмучаш - Кельмаксола - Лайсола') WHERE highway_name LIKE "%";
UPDATE station_data SET highway_name = REPLACE(highway_name, 'Малое Онучино-Зашижемье', 'Малое Онучино - Зашижемье') WHERE highway_name LIKE "%";
UPDATE station_data SET station_name = REPLACE(station_name, ' ', null) WHERE station_name = ' ';

INSERT INTO highway 
SELECT DISTINCT 
 highway_name 
FROM station_data;

delimiter $$
CREATE FUNCTION get_distance(kilometers INT, meters INT)
RETURNS FLOAT DETERMINISTIC
RETURN cast(kilometers AS FLOAT) + meters / 1000
$$


SET FOREIGN_KEY_CHECKS=0;

INSERT INTO station (station_name, is_pavilion, distance, highway_name, position_id)
	SELECT
		station_name,
        (IF (is_pavillon = 'Есть', 1, 0)),
        get_distance(station_distance_km, station_distance_m),
        highway_name,
        (IF (station_relative_position = 'Слева', 1, 2))
	FROM station_data;
    
SET FOREIGN_KEY_CHECKS=1;
