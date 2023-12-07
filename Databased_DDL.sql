-- Project 2 Alien Adoption Table Instantiation
-- By Connor MacKinnon, Jake Richardson, Hannah Zimmerman

CREATE TABLE Family(
    ID SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    income DECIMAL(10, 2),
    planet_of_residence VARCHAR(50)
);

CREATE TABLE Inhabits (
    alien_id  PRIMARY KEY REFERENCES Alien(ID),
    planet REFERENCES Planet(name)  --a families planet may be null if they are on a spacecraft
);

CREATE TABLE Adoption_request (
     request_id SERIAL PRIMARY KEY,
     alien_id INT REFERENCES alien(alien_id),
     family_id INT REFERENCES family(family_id),
     UNIQUE (alien_id, family_id) -- Ensures a family cannot request the same alien twice
 );

CREATE TABLE Agency (
    name VARCHAR(50) PRIMARY KEY,
    planet VARCHAR(50) REFERENCES planet(name)
        on delete set null
);

CREATE TABLE Planet (
    name VARCHAR(50) PRIMARY KEY,
    galaxy VARCHAR(50) NOT NULL,
    climate VARCHAR(50) NOT NULL
);

CREATE TABLE Orphanages (
    name VARCHAR(50) PRIMARY KEY,
    agency VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Medical (
    alien_id INT PRIMARY KEY REFERENCES Alien (ID),
    age INT,
    vaccinated BOOLEAN
);

CREATE TABLE Alien (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    -- home_planet VARCHAR(50) REFERENCES Planet (name)
    --     on delete set null,
    orphanage VARCHAR(50) REFERENCES Orphanages
		on delete set null
);


CREATE TABLE Home_planet (
    alien_id INT PRIMARY KEY REFERENCES Alien(ID),
    planet REFERENCES Planet(name)
);


CREATE TABLE Adopted (
    alien_id INT PRIMARY KEY REFERENCES Alien(ID) 
        ON DELETE CASCADE,
    family_id INT REFERENCES family(ID) 
        ON DELETE SET NULL, 
    UNIQUE (alien_id, family_id) -- Ensures a family cannot adopted the same alien twice
);