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
    place VARCHAR(5), 
    city VARCHAR(30), 
    country VARCHAR(30), 
    PRIMARY KEY(id)
);

CREATE TABLE NobelPrize(
    id INT, 
    awardYear INT, 
    category VARCHAR(25), 
    sortOrder INT, 
    PRIMARY KEY(id)
);

CREATE TABLE Affiliations(
    id INT,
    name VARCHAR(100), 
    city VARCHAR(30), 
    country VARCHAR(30), 
    PRIMARY KEY(id)
);

-- Load files
LOAD DATA LOCAL INFILE './people.del' INTO TABLE People
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

LOAD DATA LOCAL INFILE './organization.del' INTO TABLE Organization
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

LOAD DATA LOCAL INFILE './birth-founded.del' INTO TABLE BirthFounded
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

LOAD DATA LOCAL INFILE './nobel-prize.del' INTO TABLE NobelPrize
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

LOAD DATA LOCAL INFILE './affiliations.del' INTO TABLE Affiliations
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';