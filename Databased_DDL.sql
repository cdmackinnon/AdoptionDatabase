-- ===============================================
-- Project 2 Alien Adoption Table Instantiation
-- By Connor MacKinnon, Jake Richardson, Hannah Zimmerman
-- ===============================================

-- Description: Stores information about planets
CREATE TABLE Planet (
    name VARCHAR(50) PRIMARY KEY,
    galaxy VARCHAR(50) NOT NULL,
    climate VARCHAR(50) NOT NULL
);

-- Description: Stores information about family identifying each by ID
-- Last names are required. Income max: 999999999.99 and min: 0.00
CREATE TABLE Family(
    ID SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    income DECIMAL(11, 2) CHECK (income >= 0)
);

-- Description: Stores information about Agencies identifying each by unique names
-- Agencies must have a planet they're located on. Multiple agencies may exist on a planet
CREATE TABLE Agency (
    name VARCHAR(50) PRIMARY KEY,
    planet VARCHAR(50) REFERENCES Planet(name)
);

-- Description: Stores information about Orphanages identifying each by unique names
-- Orphanages must have an Agency they're associated with
-- Different agencies may have the same named orphanages
CREATE TABLE Orphanages (
    name VARCHAR(50) NOT NULL,
    agency VARCHAR(50) REFERENCES Agency(name),
    PRIMARY KEY (name, agency) 
);

-- Description: Stores information about Aliens identifying each by unique IDs
-- Aliens must have an orphanage they are associated with
-- TODO consider implications of a deleted orphanage/agency 
-- CASCADE vs RESTRICT. Delete alien or prevent deletion, ER DIAGRAM demands name + agency exist in alien
CREATE TABLE Alien (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    orphanage_name VARCHAR(50) NOT NULL,
    orphanage_agency VARCHAR(50) REFERENCES Agency(name),
    FOREIGN KEY (orphanage_name, orphanage_agency) REFERENCES Orphanages(name, agency) ON DELETE CASCADE
);

-- Description: Stores information about Alien Medical Records identifying each by Alien IDs
-- Vaccination Status and Age can be null (unknown)
CREATE TABLE Medical (
    alien_id INT PRIMARY KEY REFERENCES Alien (ID),
    age INT,
    vaccinated BOOLEAN
);

-- Description: Stores information about Alien Home Planets 
CREATE TABLE Home_planet (
    alien_id INT PRIMARY KEY REFERENCES Alien(ID),
    planet REFERENCES Planet(name)
);

-- Description: Stores information about aliens/families adoptions
-- An alien may not always have a family
-- A family cannot adopt the same alien twice
CREATE TABLE Adopted (
    alien_id INT PRIMARY KEY REFERENCES Alien(ID) 
        ON DELETE CASCADE,
    family_id INT REFERENCES family(ID) 
        ON DELETE SET NULL, 
    UNIQUE (alien_id, family_id)
);