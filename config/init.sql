CREATE USER name WITH PASSWORD 'pass';
CREATE DATABASE name;
GRANT ALL PRIVILEGES ON DATABASE  TO name;
\c name

CREATE TABLE test_table (
  id int,
  name varchar NOT NULL,
  comment varchar
);