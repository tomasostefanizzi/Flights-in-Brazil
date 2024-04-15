-- QUERY 1 - for each plane model,print some stats as it's avg speed, avg liters consumed etc.
SELECT
  ds_modelo AS plane_model,
  COUNT(*) AS flights_count,
  AVG(nr_velocidade_media) AS avg_speed,
  AVG(lt_combustivel) AS avg_liters,
  AVG(nr_horas_voadas) AS avg_hours_per_flight,
  AVG(km_distancia) AS avg_distance_in_km,
  AVG(kg_payload) AS avg_payload_in_kg
FROM 
  bd2.flights
WHERE 
  lt_combustivel != 0 
  AND nr_horas_voadas != 0 
  AND kg_payload != 0 
  AND nr_velocidade_media != 0 
  AND km_distancia != 0
GROUP BY 
  ds_modelo
ORDER BY 
  flights_count DESC;

-- QUERY 2 - list companies and their total distance traveled + total hours of flight
SELECT
  nm_empresa,
  SUM(km_distancia) AS total_distance, 
  SUM(nr_horas_voadas) as total_hours
FROM bd2.flights 
GROUP BY nm_empresa
ORDER BY total_distance DESC;


-- QUERY 3 - find all the routes in the database. also, count how many times they have been done.
SELECT
  nm_aerodromo_origem AS origin_airport,
  iata_airport_origem AS IATA_origin,
  nm_aerodromo_destino AS destination_airport,
  iata_airport_destino AS IATA_destination,
  COUNT(*) AS route_count
FROM
  bd2.flights
GROUP BY
  id_aerodromo_origem,
  nm_aerodromo_origem,
  iata_airport_origem,
  id_aerodromo_destino,
  nm_aerodromo_destino,
  iata_airport_destino
ORDER BY
  route_count DESC;

 