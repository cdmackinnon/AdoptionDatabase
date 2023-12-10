-- Project 2 Alien Adoption Table Population
-- By Connor MacKinnon, Jake Richardson, Hannah Zimmerman
-- SQL statements to populate a small example of your database
-- The inserted tuples must exercise all integrity constraints of your design

INSERT INTO Planet (name, galaxy, climate) VALUES
    ('Earth', 'Milky Way', 'Temperate'),
    ('Mars', 'Milky Way', 'Cold'),
    ('Venus', 'Milky Way', 'Hot'),
    ('Anubisia', 'Osiris Expanse', 'Inferno');

INSERT INTO Family (ID, last_name, income) VALUES
    (123, 'Smith', 75000.00),
    (321, 'Jones', 60000.00),
    (444, 'Williams', 90000.00),
    (565, 'Johnson', 45000.00);

INSERT INTO Agency (name, planet) VALUES
    ('Galactic Adoption Agency', 'Earth'),
    ('Cosmic Adoption Agency', 'Mars'),
    ('Vast Adoption Agency', 'Venus');

INSERT INTO Orphanages (name, agency) VALUES
    ('Stellar Orphanage', 'Galactic Adoption Agency'),
    ('Celestial Orphanage', 'Cosmic Adoption Agency'),
    ('Lunar Orphanage', 'Galactic Adoption Agency'),
    ('Lunar Orphanage', 'Vast Adoption Agency');

INSERT INTO Alien (ID, name, orphanage_name, agency_name) VALUES
    (00000, 'Sally', 'Lunar Orphanage', 'Galactic Adoption Agency'),
    (12345, 'Elon', 'Stellar Orphanage', 'Galactic Adoption Agency'),
    (88888, 'Luna', 'Lunar Orphanage', 'Galactic Adoption Agency'),
    (98765, 'Xeno', 'Lunar Orphanage', 'Vast Adoption Agency'),
    (22333, 'Sheldon', 'Celestial Orphanage', 'Cosmic Adoption Agency'),
    (55555, 'Harry', 'Stellar Orphanage', 'Galactic Adoption Agency');

INSERT INTO Medical (alien_id, age, vaccinated) VALUES
    (00000, NULL, NULL),
    (12345, 52, FALSE),
    (88888, 300, TRUE),
    (98765, 8, TRUE),
    (22333, 14, TRUE),
    (55555, 3958, TRUE);

INSERT INTO Home_planet (alien_id, planet) VALUES
    (00000, NULL),
    (12345, 'Earth'),
    (88888, 'Earth'),
    (98765, 'Venus'),
    (22333, 'Mars'),
    (55555, 'Earth');

INSERT INTO Inhabits (family_id, planet) VALUES
    (123, 'Earth'),
    (321, NULL),
    (444, 'Venus'),
    (565, 'Mars');

INSERT INTO Adoption_request (alien_id, family_id) VALUES
    (55555, 123),
    (22333, 565),
    (12345, 321);

INSERT INTO Adopted (alien_id, family_id) VALUES
    (00000, 444);