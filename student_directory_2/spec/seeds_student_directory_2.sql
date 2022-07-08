-- -------------------------------------------------------------
-- TablePlus 4.5.0(396)
--
-- https://tableplus.com/
--
-- Database: design
-- Generation Time: 2022-04-27 17:13:27.2140
-- -------------------------------------------------------------
TRUNCATE TABLE cohorts RESTART IDENTITY CASCADE;
TRUNCATE TABLE students RESTART IDENTITY CASCADE;

DROP TABLE IF EXISTS "public"."cohorts" CASCADE;

-- Create the table without the foreign key first.
CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  starting_date date
);

DROP TABLE IF EXISTS "public"."students" CASCADE;

-- Then the table with the foreign key first.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text,
-- The foreign key name is always {other_table_singular}_id
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id) references cohorts(id)
);

INSERT INTO "public"."cohorts" ("name", "starting_date") VALUES
('June 22', '2022-07-22'),
('July 22', '2022-07-22'),
('August 22', '2022-08-22'),
('September 22', '2022-09-22');

INSERT INTO "public"."students" ("name", "cohort_id") VALUES
('Maria', 1),
('Shaun', 1),
('Alex', 2),
('Rosa', 2),
('Sveta', 3),
('Claire', 3),
('Margherita', 3);