-- QUERY 1 - for each plane model,print some stats as it's avg speed, avg liters consumed etc.
SELECT
  e.ds_modelo AS plane_model,
  COUNT(*) AS flights_count,
  AVG(f.nr_velocidade_media) AS avg_speed,
  AVG(f.lt_combustivel) as avg_liters,
  AVG(f.nr_horas_voadas) as avg_hours_per_flight,
  AVG(f.km_distancia)as avg_distance_in_km,
  AVG(f.kg_payload) as avg_payload_in_kg
FROM
  bd2.flights f
JOIN
  bd2.equipment e ON f.id_equipamento = e.id_equipamento
WHERE f.lt_combustivel != 0 and f.nr_horas_voadas != 0 and f.kg_payload != 0 and f.nr_velocidade_media != 0 and f.km_distancia != 0
GROUP BY
  e.ds_modelo
ORDER BY
  flights_count DESC
 -- LIMIT 10
  
  
-- there is a plane which is not displayed. this means that it doesn't have some of the conditions present in the join.
SELECT
  e.id_equipamento as id,
  e.ds_modelo as model
FROM
  bd2.equipment e
LEFT JOIN (
  SELECT
    e.id_equipamento as id,
    e.ds_modelo AS plane_model
  FROM
    bd2.flights f
  JOIN
    bd2.equipment e ON f.id_equipamento = e.id_equipamento
  WHERE
    f.lt_combustivel != 0
    AND f.nr_horas_voadas != 0
    AND f.kg_payload != 0
    AND f.nr_velocidade_media != 0
    AND f.km_distancia != 0
  GROUP BY
  	e.id_equipamento,
    e.ds_modelo
) AS subquery ON e.id_equipamento  = subquery.id
WHERE
  subquery.id IS NULL;
 -- the model is BOEING 737 MAX 8, with id = 505
 
 SELECT *
 FROM bd2.flights f
 WHERE f.id_equipamento = 505
-- since there are just 3 flights, it's not goin to be statistically relevant

  
  
-- ========================================================================================================================================== --

-- QUERY 2 - list companies and their total distance traveled + total hours of flight
 
SELECT
  c.nm_empresa,
  SUM(f.km_distancia) AS total_distance, SUM(f.nr_horas_voadas) as total_hours
FROM bd2.company c
JOIN bd2.flights f ON c.id_empresa = f.id_empresa
GROUP BY c.nm_empresa
ORDER BY total_distance DESC 


-- ========================================================================================================================================== --

-- QUERY 3 - find all the routes in the database. also, count how many times they have been done.

-- just to check the number of routes
SELECT count(*) as number_of_routes
FROM(
SELECT DISTINCT
  f.id_aerodromo_origem AS origin_airport_id,
  a_origem.nm_aerodromo AS origin_airport,
  f.id_aerodromo_destino AS destination_airport_id,
  a_destino.nm_aerodromo AS destination_airport
FROM
  bd2.flights f
JOIN
  bd2.airport a_origem ON f.id_aerodromo_origem = a_origem.id_aerodromo
JOIN
  bd2.airport a_destino ON f.id_aerodromo_destino = a_destino.id_aerodromo) AS querys
 
 
 -- actual query
  
SELECT
  a_origem.nm_aerodromo AS origin_airport,
  a_origem.sg_iata as IATA_origin,
  a_destino.nm_aerodromo AS destination_airport,
  a_destino.sg_iata as IATA_destination,
  COUNT(*) AS route_count
FROM
  bd2.flights f
JOIN
  bd2.airport a_origem ON f.id_aerodromo_origem = a_origem.id_aerodromo
JOIN
  bd2.airport a_destino ON f.id_aerodromo_destino = a_destino.id_aerodromo
GROUP BY
  f.id_aerodromo_origem,
  a_origem.nm_aerodromo,
  f.id_aerodromo_destino,
  a_destino.nm_aerodromo
ORDER BY
  route_count DESC
 
  
 


 
 