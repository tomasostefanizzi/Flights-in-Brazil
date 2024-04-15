
---------------------------------------------------------------------------------------------------------------
-- SQL PART
---------------------------------------------------------------------------------------------------------------

-- ------- QUERY TO MERGE THE TABLES INTO JUST ONE (IN SQL!!!)
SELECT 
	f.*, 
	c.sg_empresa_icao, c.sg_empresa_iata, c.nm_empresa, c.ds_tipo_empresa, 
	l.cd_tipo_linha, l.ds_tipo_linha, l.ds_natureza_tipo_linha, l.ds_servico_tipo_linha, 
	e.sg_equipamento_icao, e.ds_modelo, 
	airport_destino.sg_icao as icao_airport_destino, airport_destino.sg_iata as iata_airport_destino, 
	airport_destino.nm_aerodromo as nm_aerodromo_destino, airport_destino.nm_municipio as nm_municipio_destino, 
	airport_destino.nm_pais as nm_pais_destino, airport_destino.nm_continente as nm_continente_destino,
	airport_origem.sg_icao as icao_airport_origem, airport_origem.sg_iata as iata_airport_origem, 
	airport_origem.nm_aerodromo as nm_aerodromo_origem, airport_origem.nm_municipio as nm_municipio_origem, 
	airport_origem.nm_pais as nm_pais_origem, airport_origem.nm_continente as nm_continente_origem
FROM bd2.flights f
	JOIN bd2.company c ON f.id_empresa = c.id_empresa
	JOIN bd2.line l ON f.id_tipo_linha = l.id_tipo_linha
	JOIN bd2.equipment e ON f.id_equipamento = e.id_equipamento
	JOIN bd2.airport AS airport_origem ON f.id_aerodromo_origem = airport_origem.id_aerodromo
	JOIN bd2.airport AS airport_destino ON f.id_aerodromo_destino = airport_destino.id_aerodromo


---------------------------------------------------------------------------------------------------------------
-- CASSANDRA PART:																							   
---------------------------------------------------------------------------------------------------------------
DROP KEYSPACE IF EXISTS bd2;
CREATE KEYSPACE bd2 WITH REPLICATION = {'class':'SimpleStrategy', 'replication_factor' : 1};

-- USE THE CREATED KEYSPACE 
USE bd2;

-- CREATE THE TABLE
CREATE TABLE Flights (
    id_basica INT PRIMARY KEY,
    id_empresa INT,
    id_tipo_linha INT,
    nr_semana_partida_real INT,
    id_aerodromo_origem INT,
    nr_semana_chegada_real INT,
    id_equipamento INT,
    ds_matricula TEXT,
    id_aerodromo_destino INT,
    lt_combustivel INT,
    nr_assentos_ofertados INT,
    kg_payload INT,
    km_distancia INT,
    nr_horas_voadas FLOAT,
    nr_velocidade_media DECIMAL,
    sg_empresa_icao TEXT,
    sg_empresa_iata TEXT,
    nm_empresa TEXT,
    ds_tipo_empresa TEXT,
    cd_tipo_linha TEXT,
    ds_tipo_linha TEXT,
    ds_natureza_tipo_linha TEXT,
    ds_servico_tipo_linha TEXT,
    sg_equipamento_icao TEXT,
    ds_modelo TEXT,
    icao_airport_destino TEXT,
    iata_airport_destino TEXT,
    nm_aerodromo_destino TEXT,
    nm_municipio_destino TEXT,
    nm_pais_destino TEXT,
    nm_continente_destino TEXT,
    icao_airport_origem TEXT,
    iata_airport_origem TEXT,
    nm_aerodromo_origem TEXT,
    nm_municipio_origem TEXT,
    nm_pais_origem TEXT,
    nm_continente_origem TEXT,
    hour_partida_real INT,
    minutes_partida_real INT,
    hour_chegada_real INT,
    minutes_chegada_real INT,
    year_partida_real INT,
    month_partida_real INT,
    day_partida_real INT,
    year_chegada_real INT,
    month_chegada_real INT,
    day_chegada_real INT
);


-- COMMAND TO PASTE INTO THE CASSANDRA CONTAINER
COPY Flights (id_basica, id_empresa, id_tipo_linha, nr_semana_partida_real, id_aerodromo_origem, nr_semana_chegada_real, id_equipamento, ds_matricula, id_aerodromo_destino, lt_combustivel, nr_assentos_ofertados, kg_payload, km_distancia, nr_horas_voadas, nr_velocidade_media, sg_empresa_icao, sg_empresa_iata, nm_empresa, ds_tipo_empresa, cd_tipo_linha, ds_tipo_linha, ds_natureza_tipo_linha, ds_servico_tipo_linha, sg_equipamento_icao, ds_modelo, icao_airport_destino, iata_airport_destino, nm_aerodromo_destino, nm_municipio_destino, nm_pais_destino, nm_continente_destino, icao_airport_origem, iata_airport_origem, nm_aerodromo_origem, nm_municipio_origem, nm_pais_origem, nm_continente_origem, hour_partida_real, minutes_partida_real, hour_chegada_real, minutes_chegada_real, year_partida_real, month_partida_real, day_partida_real, year_chegada_real, month_chegada_real, day_chegada_real) FROM 'var/lib/cassandra/csv/full_dataset.csv' WITH DELIMITER = ';' AND HEADER = true;



-- checking the number of records 
SELECT count(*) FROM bd2.flights;
-- perfect :)


-- inspect the values
SELECT * from bd2.flights;
