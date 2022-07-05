-- -------------------------------------------------------------
-- TablePlus 4.5.0(396)
--
-- https://tableplus.com/
--
-- Database: design
-- Generation Time: 2022-04-27 17:13:27.2140
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."cohorts";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS cohorts_id_seq;

-- Table Definition
CREATE TABLE "public"."cohorts" (
    "id" SERIAL,
    "name" text,
    "starting_date" date,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."students";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS students_id_seq;

-- Table Definition
CREATE TABLE "public"."students" (
    "id" SERIAL,
    "name" text,
    "cohort_id" int,
    PRIMARY KEY ("id")
);

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO cohorts (name, starting_date) VALUES 
('April', '2022-04-22'),
('May', '2022-05-22'),
('June', '2022-06-22');


INSERT INTO students (name, cohort_id) VALUES 
('Ev', '1'),
('Maria', '1'),
('Anna', '2'),
('Lucas', '3'),
('Josh', '3');
