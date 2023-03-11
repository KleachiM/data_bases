SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE
 '/Users/mihailkalinin/учеба/Институт ПС/data_bases/lw2/station.csv'
 INTO TABLE station_data
 FIELDS TERMINATED BY ',' ENCLOSED BY '"'
 LINES TERMINATED BY '\n'
 IGNORE 1 LINES;

INSERT INTO `mydb`.`position` (position)
SELECT DISTINCT
 station_relative_position
FROM mydb.station_data;

SET SQL_SAFE_UPDATES = 0; -- отключение safe update т.к. в station_data нет первичного ключа
UPDATE station_data SET highway_name = REPLACE(highway_name, 'Кучки-Кучкинское лесничество', 'Кучки - Кучкинское лесничество') WHERE highway_name LIKE "%";
UPDATE station_data SET highway_name = REPLACE(highway_name, 'Великополье-Зеленый', 'Великополье - Зеленый') WHERE highway_name LIKE "%";
UPDATE station_data SET highway_name = REPLACE(highway_name, 'Михайловка-Большеникольск', 'Михайловка - Большеникольск') WHERE highway_name LIKE "%";
UPDATE station_data SET highway_name = REPLACE(highway_name, 'Мананмучаш-Кельмаксола-Лайсола', 'Мананмучаш - Кельмаксола - Лайсола') WHERE highway_name LIKE "%";
UPDATE station_data SET highway_name = REPLACE(highway_name, 'Малое Онучино-Зашижемье', 'Малое Онучино - Зашижемье') WHERE highway_name LIKE "%";

INSERT INTO highway 
SELECT DISTINCT 
 highway_name 
FROM station_data

delimiter $$
create function is_pavillion (s varchar(10))
returns tinyint(1) deterministic
begin
	if (s = 'Есть') then
		return 1;
	else
		return 0;
	end if;
end;
$$

delimiter $$
create function get_distance(kilometers int, meters int)
returns float deterministic
return 
$$

select is_pavillion(is_pavillon) from station_data;
