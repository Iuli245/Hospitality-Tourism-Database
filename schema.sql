-- Database schema for Hospitality & Tourism Management

CREATE TABLE Utilizatori (
    id_utilizator NUMBER PRIMARY KEY,
    nume_complet VARCHAR2(100),
    parola VARCHAR2(100),
    adresa_email VARCHAR2(100),
    telefon VARCHAR2(14),
    data_nastere DATE,
    domiciliul VARCHAR2(150)
);

CREATE TABLE Hoteluri (
    id_hotel NUMBER PRIMARY KEY,
    nume_hotel VARCHAR2(100),
    adresa_hotel VARCHAR2(150),
    numar_de_stele NUMBER,
    numar_de_camere NUMBER,
    pret_mediu_pe_noapte NUMBER(10,2)
);

CREATE TABLE Atractii_Turistice (
    id_atractie NUMBER PRIMARY KEY,
    nume_atractie VARCHAR2(100),
    locatie VARCHAR2(100),
    descriere VARCHAR2(1000),
    interval_orar_de_vizitare VARCHAR2(100)
);

CREATE TABLE Rezervari (
    id_rezervare NUMBER PRIMARY KEY,
    id_hotel NUMBER,
    data_efectuare_rezervare DATE,
    data_check_in DATE,
    data_check_out DATE,
    numar_adulti NUMBER,
    numar_copii NUMBER,
    numar_de_camere_rezervate NUMBER,
    id_utilizator NUMBER,
    FOREIGN KEY (id_hotel) REFERENCES Hoteluri(id_hotel),
    FOREIGN KEY (id_utilizator) REFERENCES Utilizatori(id_utilizator)
);

CREATE TABLE Restaurant_Hotel (
    id_restaurant NUMBER PRIMARY KEY,
    id_hotel NUMBER,
    nume_restaurant VARCHAR2(100),
    tip_bucatarie VARCHAR2(100),
    interval_orar_de_functionare VARCHAR2(100),
    FOREIGN KEY (id_hotel) REFERENCES Hoteluri(id_hotel)
);

CREATE TABLE Servicii_Curatenie_Hotel (
    id_serviciu_curatenie NUMBER PRIMARY KEY,
    id_hotel NUMBER,
    tip_serviciu VARCHAR2(100),
    pret_serviciu NUMBER(10,2),
    interval_orar_de_disponibilitate VARCHAR2(100),
    descriere_serviciu VARCHAR2(1000),
    FOREIGN KEY (id_hotel) REFERENCES Hoteluri(id_hotel)
);

CREATE TABLE Recenzii_Hotel (
    id_recenzii NUMBER PRIMARY KEY,
    id_hotel NUMBER,
    id_atractie NUMBER,
    nota_acordata NUMBER(3,1),
    data_recenzie DATE,
    id_utilizator NUMBER,
    FOREIGN KEY (id_hotel) REFERENCES Hoteluri(id_hotel),
    FOREIGN KEY (id_atractie) REFERENCES Atractii_Turistice(id_atractie),
    FOREIGN KEY (id_utilizator) REFERENCES Utilizatori(id_utilizator)
);
