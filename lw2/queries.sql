use stations;

-- все остановки с павильоном

SELECT 
    station_name
FROM
    station
WHERE
    is_pavilion = 1;
    
-- все остановки слева от дороги "Звенигово - Шелангер - Морки"

SELECT 
    station_name
FROM
    station
WHERE
    highway_name = 'Звенигово - Шелангер - Морки'
        AND position_id = (SELECT 
            id
        FROM
            position
        WHERE
            position = 'Слева');
            
-- тоже самое через join

-- SELECT 
--     station.station_name, position.position
-- FROM
--     station
--         INNER JOIN
--     position ON station.position_id = position.id
-- WHERE
--     highway_name = 'Звенигово - Шелангер - Морки'
--         AND position = 'Слева';

-- все остановки по названию "Дачи"

SELECT 
    *
FROM
    station
WHERE
    station_name = 'Дачи';
    
-- все остановки в интервале от 20 до 80 км включительно на дороге "Йошкар-Ола - Уржум"

SELECT 
    *
FROM
    station
WHERE
    (distance BETWEEN 20 AND 80)
        AND highway_name = 'Йошкар-Ола - Уржум';