# Flight Data Analysis
![Airplane](images/flights.jpeg)

This repository contains the code and documentation for analyzing flight data from and to Brazil in the year 2020. The project aims to answer specific analytical questions by querying a dataset obtained from the website of the Agência Nacional de Aviação Civil (ANAC), Brazil's regulatory agency for civil aviation.

## Description

This assignment involves acquiring a dataset from an online source and conducting various queries to address chosen analytical questions. For this project, the focus is on analyzing flights to and from Brazil in the year 2020. The dataset used for this analysis is publicly available on the website of the Agência Nacional de Aviação Civil (ANAC), the regulatory agency responsible for overseeing and regulating civil aviation activities within Brazil. Airlines are mandated to share several pieces of information with ANAC to ensure safety, compliance with regulations, and protection of both industry and passenger interests.

## Project Setup - Structure

The repository is organized in the following manner: 
```
📦 FLIGHTS-IN-BRAZIL
  |- 📄 README.md        # This file
  |- 📄 Report.pdf       # Report for the project
  |- 📄 .gitignore       # Ignore .csv commits
  |- 📂 data_cleaning    # Folder for data cleaning
  |    |- 📂 dataset     # Original and processed data
  |- 📂 01-SQL           # Folder for SQL scripts
  |- 📂 02-Cassandra     # Folder for Cassandra scripts
  |- 📂 03-Neo4j         # Folder for Neo4j scripts
  |- 📂 images           # Floder for images in the README
```
## Data Source

The dataset used for this analysis was sourced from the website of the Agência Nacional de Aviação Civil (ANAC). It includes comprehensive information on flights to and from Brazil during the year 2020.
It's reachable [here](https://www.kaggle.com/datasets/mayconfelipemota/brazilian-data-flights).

## Data Wrangling

Before analysis, the dataset underwent a series of preprocessing steps to clean and prepare it for querying. Details of the data wrangling process are outlined in the repository.

## Data Dictionary

A detailed explanation of each variable and its meaning in the dataset is provided here for reference.

#### Table Airports

| Attribute         | Data Type   | Description                                           |
|-------------------|-------------|-------------------------------------------------------|
| id_aerodromo      | Integer     | Unique identifier for an airport.                     |
| sg_icao           | Varchar(4)  | ICAO code for the airport.                            |
| sg_iata           | Varchar(3)  | IATA code for the airport.                            |
| nm_aerodromo      | Varchar(50) | Name of the airport.                                  |
| nm_municipio      | Varchar(50) | Municipality where the airport is located.            |
| nm_pais           | Varchar(50) | Country where the airport is situated.                |
| nm_continente     | Varchar(30) | Continent where the airport is situated.              |

#### Table Line
| Attribute             | Data Type   | Description                                                                 |
|-----------------------|-------------|-----------------------------------------------------------------------------|
| id_tipo_linha         | Integer     | Unique identifier for a line type.                                          |
| cd_tipo_linha         | Char        | Code representing the type of line.                                         |
| ds_tipo_linha         | Varchar(30) | Description of the line type.                                               |
| ds_natureza_tipo_linha| Varchar(15) | Nature of the line type.                                                    |
| ds_servico_tipo_linha | Varchar(15) | Description of the service referring to the type of line (Passenger/Cargo). |

#### Table Equipment
| Attribute               | Data Type   | Description                                                                       |
|-------------------------|-------------|-----------------------------------------------------------------------------------|
| id_equipamento          | Integer     | Code identifying the aircraft model.                                              |
| sg_equipamento_icao     | Varchar(4)  | ICAO designator of the aircraft model ("Type Designator").                         |
| ds_modelo               | Varchar(50) | Description of the aircraft model.                                                 |

#### Table Company
| Attribute         | Data Type   | Description                                                                                      |
|-------------------|-------------|--------------------------------------------------------------------------------------------------|
| id_empresa        | Integer     | Unique identifier for a company.                                                                 |
| sg_empresa_icao   | Varchar(3)  | ICAO acronym of the airline. Refers to the designator of the air transport company obtained from the ICAO (International Civil Aviation Organization).|
| sg_empresa_iata   | Varchar(2)  | IATA acronym for the airline. Refers to the air transport company designator obtained from IATA (International Air Transport Association).|                                                
| nm_empresa        | Varchar(100)| Airline name.                                                                                    |
| ds_tipo_empresa   | Text        | Description of the type of company. Refers to the description of the type of company in relation to the serviceperformed.                                                             


#### Table Flight
| Key               | Data Type       | Description                                    |
|-------------------|-----------------|------------------------------------------------|
| id_basica         | Integer         | Unique identifier for a flight.               |
| id_aerodromo_origem | Integer       | Foreign key referring to the origin airport.  |
| id_aerodromo_destino | Integer       | Foreign key referring to the destination airport. |
| id_empresa        | Integer         | Foreign key referring to the airline company. |
| id_tipo_linha     | Integer         | Foreign key referring to the type of flight line. |
| id_equipamento    | Integer         | Foreign key referring to the aircraft model.  |
| hr_partida_real   | TIME(0)         | Actual departure time.                        |
| dt_partida_real   | Datetime        | Actual departure date.                        |
| nr_semana_partida_real | Integer     | Week number of actual departure.              |
| hr_chegada_real   | TIME(0)         | Actual arrival time.                          |
| dt_chegada_real   | Datetime        | Actual arrival date.                          |
| nr_semana_chegada_real | Integer     | Week number of actual arrival.                |
| ds_matricula      | Varchar(3)      | Aircraft registration code.                   |
| lt_combustivel    | Integer         | Fuel capacity in liters.                      |
| nr_assentos_ofertados | Integer      | Number of offered seats.                     |
| kg_payload        | Integer         | Payload weight in kilograms.                  |
| km_distancia      | Integer         | Flight distance in kilometers.                |
| nr_horas_voadas   | Real            | Flying hours for a single flight.             |
| nr_velocidade_media | Real          | Average flight speed.                         |


## Analytical Questions and Answers

The main focus of this project is to address specific analytical questions related to flights to and from Brazil in 2020, using three different techologies. Tha analytical questions I proposed are:
-   for each plane model,print some stats as it's avg speed, avg liters consumed etc.
-   list companies and their total distance traveled + total hours of flight
-   find all the routes in the database. also, count how many times they have been done.

For more details, check the [Report](Report.pdf). Enjoy :)!
