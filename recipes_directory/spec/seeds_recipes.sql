-- -------------------------------------------------------------
-- TablePlus 4.5.0(396)
--
-- https://tableplus.com/
--
-- Database: design
-- Generation Time: 2022-04-27 17:13:27.2140
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."recipes";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS recipes_id_seq;

-- Table Definition

CREATE TABLE "public"."recipes" (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "cooking_time" int,
  "rating" int
);

INSERT INTO recipes (name, cooking_time, rating) VALUES 
('Salad', 20, 5),
('Soup', 40, 3);