-- Example queries for Hospitality & Tourism Database

-- Get all users
SELECT * FROM Utilizatori;

-- Get all hotels with more than 3 stars
SELECT nume_hotel, numar_de_stele, pret_mediu_pe_noapte
FROM Hoteluri
WHERE numar_de_stele > 3;

-- Get average review score for each hotel
SELECT h.nume_hotel, AVG(r.nota_acordata) AS average_rating
FROM Hoteluri h
JOIN Recenzii_Hotel r ON h.id_hotel = r.id_hotel
GROUP BY h.nume_hotel;

-- Get reservations for a specific user
SELECT r.id_rezervare, h.nume_hotel, r.data_check_in, r.data_check_out
FROM Rezervari r
JOIN Hoteluri h ON r.id_hotel = h.id_hotel
WHERE r.id_utilizator = 1;

-- List cleaning services for a hotel
SELECT h.nume_hotel, s.tip_serviciu, s.pret_serviciu
FROM Hoteluri h
JOIN Servicii_Curatenie_Hotel s ON h.id_hotel = s.id_hotel
WHERE h.id_hotel = 1;
