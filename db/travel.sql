DROP TABLE trips;
DROP TABLE cities;
DROP TABLE countries;


CREATE TABLE  countries(
  id serial8 primary key,
   name varchar(255)
);

CREATE TABLE  cities(
  id serial8 primary key,
  country_id INT8 REFERENCES countries(id) ON DELETE CASCADE,
  name varchar(255)
);

CREATE TABLE  trips(
  id serial8 primary key,
  country_id INT8 REFERENCES countries(id) ON DELETE CASCADE,
  city_id INT8 REFERENCES cities(id) ON DELETE CASCADE,
  visited varchar(255)
);
