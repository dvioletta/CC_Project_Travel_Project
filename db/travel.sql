DROP TABLE cities;
DROP TABLE countries;
DROP TABLE trips;

CREATE TABLE  countries(
  id serial8 primary key,
   name varchar(255)
);

CREATE TABLE  cities(
  id serial8 primary key,
   name varchar(255),
   countries_id INT4 REFERENCES countries(id) ON DELETE CASCADE
);

CREATE TABLE  trips(
  id serial8 primary key,
  cities_id INT4 REFERENCES cities(id) ON DELETE CASCADE,
  countries_id INT4 REFERENCES countries(id) ON DELETE CASCADE,
  visited varchar(255)
);
