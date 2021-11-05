-- Creating Tables

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
    awardYear VARCHAR(4), 
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

-- Load