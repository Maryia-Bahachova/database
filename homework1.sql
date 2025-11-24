--schema1

drop table if exists payment;
drop table if exists ticket;
drop table if exists customer;
drop table if exists showtime;
drop table if exists theater_movie;
drop table if exists movie;
drop table if exists genre;
drop table if exists seat;
drop table if exists hall;
drop table if exists theater;

-- theater
create table if not exists theater
(
    theater_id serial primary key,
    name varchar(20) not null,
    address varchar(20),
    city varchar(20),
    phone varchar(20)
);

-- hall (1:n с theater)
create table if not exists hall
(
    hall_id serial primary key,
    theater_id int references theater(theater_id),
    name varchar(20) not null,
    capacity int
);

-- seat (1:n с hall)
create table if not exists seat
(
    seat_id serial primary key,
    hall_id int references hall(hall_id),
    row_number int,
    seat_number int not null,
	unique (hall_id, row_number, seat_number)
);

-- genre
create table if not exists genre
(
    genre_id serial primary key,
    genre_name varchar(20)
);

-- movie (1:n с genre)
create table if not exists movie
(
    movie_id serial primary key,
    genre_id int references genre(genre_id),
	parent_movie_id int references movie(movie_id) on delete set null,
    title varchar(20) not null,
    description varchar(100) not null,
    duration_minutes int,
    release_date date not null,
    age_rating varchar(20)
);

-- theater_movie (m:n связь между theater и movie)
create table if not exists theater_movie
(
    theater_id int references theater(theater_id),
    movie_id int references movie(movie_id),
    primary key (theater_id, movie_id)
);

-- showtime
create table if not exists showtime
(
    showtime_id serial primary key,
    movie_id int references movie(movie_id),
    hall_id int references hall(hall_id),
    start_time timestamp not null,
	end_time timestamp not null,
    base_price_eur numeric(10,2)
);

-- customer
create table if not exists customer
(
    customer_id serial primary key,
    full_name varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(20) unique,
    registration_date date
);

-- ticket
create table if not exists ticket
(
    ticket_id serial primary key,
    showtime_id int references showtime(showtime_id),
    customer_id int references customer(customer_id),
    seat_id int references seat(seat_id),
	unique (showtime_id, seat_id),
    price numeric(10,2),
    purchase_date date
);

-- payment (1:1 с ticket)
create table if not exists payment
(
    payment_id serial primary key,
    ticket_id int unique references ticket(ticket_id),
    amount numeric(10,2),
    payment_method varchar(20),
    payment_date date,
    status varchar(20)
);

--schema2

drop table if exists booking;
drop table if exists tour_price;
drop table if exists tour_schedule;
drop table if exists tour_guide;
drop table if exists guide;
drop table if exists tour_excursion;
drop table if exists excursion;
drop table if exists tour_hotel;
drop table if exists hotel;
drop table if exists tour_destination;
drop table if exists tour;
drop table if exists destination;
drop table if exists traveler;

--traveler
create table if not exists traveler
(
  traveler_id serial primary key,
  full_name varchar(100),
  phone varchar(20),
  email varchar(100),
  birth_date date,
  citizenship varchar(50),
  registration_date date
);

--destination
create table if not exists destination
(
  destination_id serial primary key,
  country varchar(50),
  city varchar(30),
  description text
);

--tour
create table if not exists tour
(
  tour_id serial primary key,
  name varchar(100),
  description text,
  duration_days int,
  base_price numeric(10,2),
  active boolean
);

--tour_destination(m:n связь между tour и destination)
create table if not exists tour_destination
(
  tour_id int references tour(tour_id),
  destination_id int references destination(destination_id),
  primary key (tour_id, destination_id)
);

--hotel
create table if not exists hotel
(
  hotel_id serial primary key,
  name varchar(50),
  address varchar(100),
  max_capacity int,
  stars int,
  phone varchar(20)
);

----tour_hotel(m:n связь между tour и hotel)
create table if not exists tour_hotel
(
  tour_id int references tour(tour_id),
  hotel_id int references hotel(hotel_id),
  primary key (tour_id, hotel_id)
);

--excursion
create table if not exists excursion
(
  excursion_id serial primary key,
  name varchar(50),
  description text,
  duration_minutes int,
  price numeric(10,2),
  language varchar(20) 
);

----tour_excursion(m:n связь между tour и excursion)
create table if not exists tour_excursion
(
  tour_id int references tour(tour_id),
  excursion_id int references excursion(excursion_id),
  primary key (tour_id, excursion_id)
);

--guide
create table if not exists guide
(
  guide_id serial primary key,
  supervisor_guide_id int references guide(guide_id) on delete set null,
  full_name varchar(100),
  languages varchar(100),
  phone varchar(20),
  email varchar(100),
  country varchar(50)
);

----tour_guide(m:n связь между tour и guide)
create table if not exists tour_guide
(
  tour_id int references tour(tour_id),
  guide_id int references guide(guide_id),
  primary key (tour_id, guide_id)
);

--tour_schedule (1:n с tour)
create table if not exists tour_schedule
(
  schedule_id serial primary key,
  tour_id int references tour(tour_id),
  start_date date,
  end_date date,
  available_places int,
  season varchar(20) check (season in ('winter', 'summer', 'spring', 'autumn'))
);

--tour_price(1:n c tour_schedule)
create table if not exists tour_price
(
  price_id serial primary key,
  schedule_id int references tour_schedule(schedule_id),
  price_per_person numeric(10,2),
  currency char(3),
  discount_percent int
);

--booking (1:n c traveler, tour_schedule)
create table if not exists booking
(
  booking_id serial primary key,
  traveler_id int references traveler(traveler_id),
  tour_schedule_id int references tour_schedule(schedule_id),
  price_id int references tour_price(price_id),
  travelers_count int,
  total_price numeric(10,2),
  booking_date date,
  status varchar(20)
);