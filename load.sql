-- Drop tables if they exist
DROP TABLE IF EXISTS People, Organization, BirthFounded, NobelPrize, Affiliations;

-- Creating tables
CREATE TABLE People(
    id INT, 
    givenName VARCHAR(50), 
    familyName VARCHAR(50), 
    gender VARCHAR(10), 
    PRIMARY KEY(id)
);

CREATE TABLE Organization(
    id INT, 
    orgName VARCHAR(80), 
    PRIMARY KEY(id)
);

CREATE TABLE BirthFounded(
    id INT, 
    birth_found DATE, 
    city VARCHAR(30), 
    country VARCHAR(30), 
    PRIMARY KEY(id)
);

CREATE TABLE NobelPrize(
    id INT, 
    awardYear INT, 
    category VARCHAR(25), 
    sortOrder INT, 
    PRIMARY KEY(id, awardYear)
);

CREATE TABLE Affiliations(
    id INT,
    name VARCHAR(100), 
    city VARCHAR(30), 
    country VARCHAR(30), 
    PRIMARY KEY(id, name)
);

-- Load files
LOAD DATA LOCAL INFILE './People.del' INTO TABLE People
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"';

LOAD DATA LOCAL INFILE './Org.del' INTO TABLE Organization
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"';

LOAD DATA LOCAL INFILE './BirthFounded.del' INTO TABLE BirthFounded
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"';

LOAD DATA LOCAL INFILE './NobelPrize.del' INTO TABLE NobelPrize
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"';

LOAD DATA LOCAL INFILE './Affiliations.del' INTO TABLE Affiliations
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"';