-- Project 2 Alien Adoption Table Instantiation
-- By Connor MacKinnon, Jake Richardson, Hannah Zimmerman


CREATE TABLE family(
    id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    income DECIMAL(10, 2),
    planet_of_residence VARCHAR(50)
);

CREATE TABLE adoption_request (
    request_id SERIAL PRIMARY KEY,
    alien_id INT REFERENCES alien(alien_id),
    family_id INT REFERENCES family(family_id),
    UNIQUE (alien_id, family_id) -- Ensures uniqueness of alien-family pairs
);

CREATE TABLE Agency (
    name VARCHAR(50) PRIMARY KEY,
    planet VARCHAR(50) REFERENCES planet(name)
);

CREATE TABLE Planet (
    name VARCHAR(50) PRIMARY KEY,
    galaxy VARCHAR(50),
    climate VARCHAR(50)
);

CREATE TABLE Orphanages (
    name VARCHAR(50) PRIMARY KEY,
    agency VARCHAR(50) PRIMARY KEY
);