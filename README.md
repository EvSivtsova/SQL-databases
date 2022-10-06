# SQL-databases

<div align="left">
  <img alt="GitHub top language" src="https://img.shields.io/github/languages/top/EvSivtsova/bank_tech_test">
</div>
<div>
  <img src="https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white"/> 
  <img src="https://img.shields.io/badge/RSpec-blue?style=for-the-badge&logo=Rspec&logoColor=white" alt="Rspec"/>
  <img src="https://img.shields.io/badge/Test_coverage:_100-blue?style=for-the-badge&logo=Rspec&logoColor=white" alt="Rspec"/>
</div><br>

These are Makers' exercises from week 3. In this module I learned how to:

* Design a database schema with at least two tables from a specification, including a one-to-many relationship between two tables, and create the schema in a database using SQL.
* Use SQL to query a database to read data from one table or resulting of a join, create new records, update and delete.
* Integrate a relational database to a program by test-driving classes which implement CRUD methods to send SQL queries to a database.

## TechBit

Technologies used: 
* Ruby(3.0.0)
* RVM
* Rspec(Testing)
* Simplecov(Test Coverage)

To install the project clone the repository and run `bundle install` to install the dependencies within the folder:

```
git clone https://github.com/EvSivtsova/SQL-databases.git
cd SQL-databases
bundle install
```
blog_directory, movie_directory and student_directory_1 folders contain databases designs only.

music_library, recipes_directory and student_directory_2 contain database designs, repository classes and tests.

Enter each of these folders and run the following commands :

**music_library**<br>

To run the tests:

```
createdb music_library_test
psql -h 127.0.0.1 music_library_test < spec/seeds_music_library.sql
rspec
```

To seed the data and run the app:
```
createdb music_library
psql -h 127.0.0.1 music_library < spec/seeds_music_library.sql
ruby app.rb
```
<img src='https://github.com/EvSivtsova/SQL-databases/blob/main/outputs/music-library-option-1.png'>

Click [here](https://github.com/EvSivtsova/SQL-databases/tree/main/outputs) for more outputs and test results.

**recipes_directory**<br>

To run the tests:
```
createdb recipes_directory_test
psql -h 127.0.0.1 recipes_directory_test < spec/seeds_recipes.sql
rspec
```

**student_directory_2**<br>

To run the tests:
```
createdb student_directory_2_test
psql -h 127.0.0.1 student_directory_2_test < spec/seeds_student_directory_2.sql
rspec
```
**student_repository**<br>

To run the tests:
```
createdb students_test
psql -h 127.0.0.1 students_test < spec/seeds_students.sql
rspec
```

Test coverage: 100%
