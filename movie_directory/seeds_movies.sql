-- -------------------------------------------------------------
-- TablePlus 4.5.0(396)
--
-- https://tableplus.com/
--
-- Database: design
-- Generation Time: 2022-04-27 17:13:27.2140
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."movies";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS movies_id_seq;

-- Table Definition
CREATE TABLE "public"."movies" (
    "id" SERIAL,
    "title" text,
    "genre" text,
    "release_year" int,
    PRIMARY KEY ("id")
);

INSERT INTO movies (title, genre, release_year) VALUES ('Minions: The Rise of Gru', 'Animation', 2022);
INSERT INTO movies (title, genre, release_year) VALUES ('Men', 'Horror', 2022);

SELECT 