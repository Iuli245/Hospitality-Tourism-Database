-- Example queries for Hospitality & Tourism Database

-- ================================
-- ALTER TABLE
-- ================================
-- Add a new column 'adresa' (address) to the Users table
ALTER TABLE Utilizatori
ADD adresa VARCHAR2(200);


-- ================================
-- UPDATE STATEMENTS
-- ================================
-- Update full name of a user
UPDATE Utilizatori
SET nume_complet = 'Maria Popescu'
WHERE id_utilizator = 1;

-- Update the star rating of a hotel
UPDATE Hoteluri
SET numar_de_stele = 3
WHERE id_hotel = 10;

-- Update operating hours of specific restaurants
UPDATE Restaurant_Hotel
SET interval_orar_de_functionare = '09:00 - 22:00'
WHERE id_restaurant = 5;

UPDATE Restaurant_Hotel
SET interval_orar_de_functionare = '09:00 - 22:00'
WHERE id_restaurant = 8;

-- Update cuisine type of a restaurant
UPDATE Restaurant_Hotel
SET tip_bucatarie = 'Internțională'
WHERE id_restaurant = 5;


-- ================================
-- INSERT STATEMENTS
-- ================================
-- Insert a new user
INSERT INTO Utilizatori (id_utilizator, nume_complet, parola, adresa_email, telefon, data_nastere, domiciliul)
VALUES (21, 'John Doe', 'parolasecreta', 'john@example.com', '0712345678', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 'Str. Primaverii nr. 20');

-- Insert a new tourist attraction
INSERT INTO Atractii_Turistice (id_atractie, nume_atractie, locatie, descriere, interval_orar_de_vizitare)
VALUES (11, 'Muzeul de Istorie', 'Bucuresti', 'Muzeu ce prezinta istoria locala', '09:00 - 17:00');

-- Insert a new hotel
INSERT INTO Hoteluri (id_hotel, nume_hotel, adresa_hotel, numar_de_stele, numar_de_camere, pret_mediu_pe_noapte)
VALUES (11, 'Hotel Ritz', 'Str. Libertatii nr. 10', 5, 100, 250.00);

-- Insert a new hotel review
INSERT INTO Recenzii_Hotel (id_recenzii, id_hotel, id_atractie, nota_acordata, data_recenzie, id_utilizator)
VALUES (44, 11, 11, 4.5, SYSDATE, 21);

-- Insert a new hotel restaurant
INSERT INTO Restaurant_Hotel (id_restaurant, id_hotel, nume_restaurant, tip_bucatarie, interval_orar_de_functionare)
VALUES (11, 11, 'Restaurant LaVita', 'Internationala', '12:00 - 22:00');


-- ================================
-- DELETE STATEMENTS
-- ================================
-- Delete a specific hotel review
DELETE FROM Recenzii_Hotel
WHERE id_recenzii = 3;


-- ================================
-- SELECT STATEMENTS
-- ================================
-- Join Users and Reservations to get user names and reservation dates
SELECT u.nume_complet, r.id_rezervare, r.data_check_in, r.data_check_out
FROM Utilizatori u
JOIN Rezervari r ON u.id_utilizator = r.id_utilizator;

-- Join Reviews and Attractions to get attraction name and formatted review date
SELECT nume_atractie, locatie, TO_CHAR(data_recenzie, 'DD/MM/YYYY') AS data_formatata
FROM Recenzii_Hotel rh
JOIN Atractii_Turistice at ON rh.id_atractie = at.id_atractie;

-- Join Users, Reservations, and Hotels
SELECT u.nume_complet, h.nume_hotel, r.data_check_in, r.data_check_out
FROM Utilizatori u
JOIN Rezervari r ON u.id_utilizator = r.id_utilizator
JOIN Hoteluri h ON r.id_hotel = h.id_hotel;

-- Search users by email (case-insensitive)
SELECT *
FROM Utilizatori
WHERE UPPER(adresa_email) = UPPER('exemplu@email.com');

-- Count total reservations per hotel
SELECT h.nume_hotel, COUNT(r.id_rezervare) AS total_rezervari
FROM Hoteluri h
JOIN Rezervari r ON h.id_hotel = r.id_hotel
GROUP BY h.nume_hotel;

-- Count total reservations per user
SELECT id_utilizator, COUNT(*) AS total_rezervari
FROM Rezervari
GROUP BY id_utilizator;

-- Find maximum average price per hotel
SELECT id_hotel, MAX(pret_mediu_pe_noapte) AS pret_maxim
FROM Hoteluri
GROUP BY id_hotel;

-- Calculate average rating per attraction
SELECT id_atractie, AVG(nota_acordata) AS nota_medie
FROM Recenzii_Hotel
GROUP BY id_atractie;

-- Sum total cleaning service price per hotel
SELECT id_hotel, SUM(pret_serviciu) AS pret_total_servicii_curatenie
FROM Servicii_Curatenie_Hotel
GROUP BY id_hotel;

-- Calculate total guests per reservation
SELECT id_rezervare, SUM(numar_adulti + numar_copii) AS total_oaspeti
FROM Rezervari
GROUP BY id_rezervare;


-- ================================
-- DECODE & CASE
-- ================================
-- DECODE example for number of adults
SELECT id_utilizator, 
       DECODE(numar_adulti,
              1, 'Un adult',
              2, 'Doi adulți',
              'Mai mulți adulți') AS nr_adulti
FROM Rezervari;

-- CASE example for number of children
SELECT id_utilizator,
       CASE 
           WHEN numar_copii = 0 THEN 'Fără copii'
           WHEN numar_copii = 1 THEN 'Un copil'
           ELSE 'Mai mulți copii'
       END AS nr_copii
FROM Rezervari;


-- ================================
-- SET OPERATORS
-- ================================
-- UNION example: combine hotel and restaurant names
SELECT id_hotel, nume_hotel FROM Hoteluri
UNION
SELECT id_hotel, nume_restaurant FROM Restaurant_Hotel;

-- MINUS example: hotels without reservations
SELECT id_hotel, nume_hotel FROM Hoteluri
MINUS
SELECT id_hotel, nume_hotel FROM Rezervari;

-- INTERSECT example: hotels with reservations
SELECT id_hotel FROM Hoteluri
INTERSECT
SELECT id_hotel FROM Rezervari;


-- ================================
-- SUBQUERY
-- ================================
-- Users with reservations after a specific date
SELECT * FROM Utilizatori
WHERE id_utilizator IN (
    SELECT id_utilizator FROM Rezervari WHERE data_check_in >= TO_DATE('2023-01-01', 'YYYY-MM-DD')
);


-- ================================
-- HIERARCHICAL QUERY
-- ================================
-- List hotels and their restaurants
SELECT h1.id_hotel AS hotel_radacina, h1.nume_hotel AS nume_hotel_principal,
       rh1.id_restaurant, rh1.nume_restaurant
FROM Hoteluri h1
LEFT JOIN Restaurant_Hotel rh1 ON h1.id_hotel = rh1.id_hotel
WHERE NOT EXISTS (
    SELECT 1
    FROM Restaurant_Hotel rh2
    WHERE rh2.id_hotel = h1.id_hotel AND rh2.id_restaurant <> rh1.id_restaurant
)
ORDER BY h1.id_hotel, rh1.id_restaurant;


-- ================================
-- VIEWS
-- ================================
-- Create a view for hotels
CREATE VIEW Vizualizare_Hoteluri AS
SELECT nume_hotel, adresa_hotel, numar_de_stele
FROM Hoteluri;


-- ================================
-- INDEX
-- ================================
-- Create index on review date for faster querying
CREATE INDEX idx_data_recenzie ON Recenzii_Hotel(data_recenzie);


-- ================================
-- SYNONYM
-- ================================
-- Create a synonym for Rezervari table
CREATE SYNONYM sin_Rezervari FOR Rezervari;


-- ================================
-- SEQUENCE
-- ================================
-- Create a sequence for generating user IDs
CREATE SEQUENCE seq_id_utilizator
START WITH 1
INCREMENT BY 1
NOCACHE;
