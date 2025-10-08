# Hospitality-Tourism-Database
# Database Project

This project represents a relational database designed for the **hospitality and tourism industry**.  
It was implemented using **Oracle SQL Developer 22.2.1**.

## Features
- User management (personal details, login credentials, contact information).
- Hotels (basic details, stars, rooms, average price per night).
- Tourist attractions (location, description, visiting schedule).
- Reservations (with check-in/check-out, number of guests and rooms).
- Restaurants within hotels (type of cuisine, operating hours).
- Cleaning services for hotels (description, availability, pricing).
- Reviews and ratings for hotels and attractions.

The project demonstrates database design using **DDL (CREATE, ALTER)** and **DML (INSERT, SELECT, UPDATE)** statements.

## Notes on Table Names

The SQL schema uses **Romanian table and column names**. For clarity, English equivalents are provided below:

| Romanian Table Name                | English Equivalent                  | Description |
|------------------------------------|-------------------------------------|-------------|
| `Utilizatori`                      | `Users`                             | Stores user information including full name, email, password, phone number, date of birth, and                                                                                address. 
| `Hoteluri`                         | `Hotels`                            | Contains hotel details such as name, address, star rating, number of rooms, and average price                                                                                 per night. 
| `Atractii_Turistice`               | `Tourist_Attractions`               | Stores information about attractions, including name, location, description, and visiting hours. 
| `Rezervari`                        | `Reservations`                      | Manages hotel reservations, including check-in/check-out dates, number of guests and rooms, and                                                                               associated user. 
| `Restaurant_Hotel`                 | `Hotel_Restaurants`                 | Contains details about restaurants within hotels, including cuisine type and operating hours. 
| `Servicii_Curatenie_Hotel`         | `Hotel_Cleaning_Services`           | Stores information on cleaning services for hotels, including service type, price, availability                                                                               schedule, and description. 
| `Recenzii_Hotel`                   | `Hotel_Reviews`                     | Stores reviews and ratings for hotels and attractions, linked to the user who submitted them. 

**Note:** The SQL files (`schema.sql` and `data.sql`) retain the original Romanian names, but English equivalents are used in this documentation for easier understanding.


## How to Run
1. Open Oracle SQL Developer (22.2.1).
2. Execute `schema.sql` to create the database tables and relationships.
3. Execute `data.sql` to populate the tables with test data.
4. Optionally, use `queries.sql` to test and retrieve information from the database.

## Example Use Cases
- Managing reservations and user details.
- Retrieving ratings for a given hotel or attraction.
- Checking available cleaning services for a hotel.
- Providing structured data for a potential online booking system.
