-- Project 2 Alien Adoption Table Instantiation
-- By Connor MacKinnon, Jake Richardson, Hannah Zimmerman

CREATE TABLE Family(
    id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    income DECIMAL(10, 2),
    planet_of_residence VARCHAR(50)
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
    alien_ID SERIAL PRIMARY KEY,
    age INT,
    vaccinated BOOLEAN
);

CREATE TABLE Alien (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    -- home_planet VARCHAR(50) REFERENCES Planet (name)
    --     on delete set null,
    -- orphanage VARCHAR(50) REFERENCES Orphanages
	-- 	on delete set null
);

CREATE TABLE Home_planet (
    alien_ID  PRIMARY KEY,
    planet REFERENCES Planet(name)
)

CREATE TABLE Houses (
    alien_ID  PRIMARY KEY REFERENCES Alien(ID),
    planet REFERENCES Planet(name)
)

CREATE TABLE Adopted (
    alien_ID SERIAL PRIMARY KEY REFERENCES Alien (ID)
        on delete cascade,
    family_id INT REFERENCES Family (ID)
        on delete set null
);