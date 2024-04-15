DROP DATABASE IF EXISTS bd2;
CREATE DATABASE bd2;
USE bd2;

-- DROP TABLE IF EXISTS airport
-- Create Table airport
CREATE TABLE airport (
  id_aerodromo INTEGER primary key,
  sg_icao VARCHAR(4),
  sg_iata VARCHAR(3),
  nm_aerodromo VARCHAR(100),
  nm_municipio VARCHAR(50),
  nm_pais VARCHAR(50),
  nm_continente VARCHAR(30)
);

-- DROP TABLE IF EXISTS line
-- Create Table line
CREATE TABLE line (
  id_tipo_linha INTEGER PRIMARY KEY,
  cd_tipo_linha CHAR,
  ds_tipo_linha VARCHAR(30),
  ds_natureza_tipo_linha VARCHAR(15),
  ds_servico_tipo_linha VARCHAR(15)
);

-- DROP TABLE IF EXISTS equipment
-- Create Table equipment
CREATE TABLE equipment (
  id_equipamento INTEGER PRIMARY KEY,
  sg_equipamento_icao VARCHAR(4),
  ds_modelo VARCHAR(50)
);

-- DROP TABLE IF EXISTS company
-- Create Table company
CREATE TABLE company (
  id_empresa INTEGER PRIMARY KEY,
  sg_empresa_icao VARCHAR(3),
  sg_empresa_iata VARCHAR(2),
  nm_empresa VARCHAR(100),
  ds_tipo_empresa TEXT
);

-- DROP TABLE IF EXISTS flights
-- Create Table flights
CREATE TABLE flights (
  id_basica INTEGER PRIMARY KEY,
  id_empresa INTEGER,
  id_tipo_linha INTEGER,
  hr_partida_real TIME(0),
  dt_partida_real DATETIME,
  nr_semana_partida_real INTEGER,
  id_aerodromo_origem INTEGER,
  hr_chegada_real TIME(0),
  dt_chegada_real DATETIME,
  nr_semana_chegada_real INTEGER,
  id_equipamento INTEGER,
  ds_matricula VARCHAR(3),
  id_aerodromo_destino INTEGER,
  lt_combustivel INTEGER,
  nr_assentos_ofertados INTEGER,
  kg_payload INTEGER,
  km_distancia INTEGER,
  nr_horas_voadas REAL,
  nr_velocidade_media DECIMAL(10,2),
  
  foreign key (id_empresa) references company(id_empresa)
    on delete restrict
    on update cascade,
    
  foreign key (id_tipo_linha) references line(id_tipo_linha)
    on delete restrict
    on update cascade,
  
  foreign key (id_aerodromo_origem) references airport(id_aerodromo)
    on delete restrict
    on update cascade,
    
  foreign key (id_equipamento) references equipment(id_equipamento)
  	on delete restrict
  	on update cascade,
 
  foreign key (id_aerodromo_destino) references airport(id_aerodromo)
    on delete restrict
    on update cascade
);
  
  

LOAD DATA INFILE '/var/lib/mysql/csv/airports.csv'      
INTO TABLE airport
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/line.csv'      
INTO TABLE line
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/company.csv'      
INTO TABLE company
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/equipment.csv'      
INTO TABLE equipment
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/flights.csv'      
INTO TABLE flights
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
