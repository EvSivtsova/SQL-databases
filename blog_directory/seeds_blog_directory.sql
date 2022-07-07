-- -------------------------------------------------------------
-- TablePlus 4.5.0(396)
--
-- https://tableplus.com/
--
-- Database: design
-- Generation Time: 2022-04-27 17:13:27.2140
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."posts";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS posts_id_seq;

-- Table Definition
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
);

DROP TABLE IF EXISTS "public"."comments";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS comments_id_seq;

-- Table Definition
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  author_name text,
  content text,
-- The foreign key name is always {other_table_singular}_id
  post_id int,
  constraint fk_post foreign key(post_id) references posts(id)
);