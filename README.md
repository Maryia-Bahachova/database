# Relational Database Design Project

This repository contains the deliverables for the Relational Database Design assignment.  
The goal of the project is to design databases for **two selected subject areas** from the provided list.  
The work demonstrates understanding of conceptual (ER), logical (relational) and physical (SQL) database design.

---

## 📌 Project Topics

### 1. Cinema Ticket Booking System
A cinema company manages several theaters, each containing multiple halls. Films are shown in specific halls at scheduled times.  
The database must store:

- film information (titles, genres, duration, description)
- theaters and halls
- showtimes and seating arrangements
- ticket prices and sales
- visitor information  
- relationships such as:  
  - visitors → tickets  
  - movies → halls → showtimes  
  - movies screened in multiple theaters

This schema models how customers purchase tickets for different movie sessions, and how films are managed across theaters.

---

### 2. Travel Agency System
A travel agency organizes tours, excursions, hotel stays, and collaborates with guides in different countries.  
The database must include:

- clients (customers)
- tours with multiple destinations
- hotels connected to tours
- excursions offered during the tour
- guides working with the agency
- tour schedules and pricing
- bookings with the number of travelers and total cost

This schema reflects the structure of booking, scheduling, and managing travel packages.

---

## 🛠 Technologies Used

- PostgreSQL (SQL DDL)
- ER and relational modeling tools (e.g., dbdiagram.io)
- Git / GitHub for version control

---


## ✔ Assignment Goals Achieved

- Domain analysis for two subject areas  
- Identification of entities, attributes, relationships, and constraints  
- ER modeling  
- Logical relational schema  
- Physical SQL implementation  
- Submission in a structured Git repository  
