{STUDENT DIRECTORY 2} # Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
# USER STORY:

As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.
```

```
Nouns:

students' name, cohorts' name, cohorts' starting date
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| student               | name,        |
| cohort                | name, starting_date |

1. Name of the first table (always plural): `students` 

    Column names: `name`

2. Name of the second table (always plural): `cohorts` 

    Column names: `name`, `starting_date`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
Table: student
id: SERIAL
name: text

Table: cohort
id: SERIAL
name: text
starting_date: date
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```
1. Can one student have many cohorts? NO
2. Can one cohort have many students? YES

-> Therefore,
-> An cohort HAS MANY students
-> A student BELONGS TO a cohort

Student -> many to one -> Cohort


-> Therefore, the foreign key is on the students table (cohort_id).
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- file: students_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  starting_date date
);

-- Then the table with the foreign key first.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text,
-- The foreign key name is always {other_table_singular}_id
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id) references cohorts(id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 student_directory_2 < seeds_student_directory_2.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: cohorts

# Model class
# (in lib/cohort.rb)
class Cohort
end

# Repository class
# (in lib/cohort_repository.rb)
class CohortRepository
end

# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Student
end

```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby

# Table name: cohorts

# Model class
# (in lib/cohort.rb)
class Cohort
  attr_accessor :id, :name,:starting_date 

  def initialize
    @students = []
  end
end


# Table name: students

# Model class
# (in lib/student.rb)

class Student
  attr_accessor :id, :name, :cohort_id
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
#Table name: cohorts

# Repository class
# (in lib/cohort_repository.rb)

class CohortRepository

  # Gets an array of cohorts with their students depending on their cohort_id value
  def find_with_students(id)
    # Executes the SQL query:
    # SELECT cohorts.id AS cohort_id, 
    # cohorts.name AS cohort, 
    # cohorts.starting_date, 
    # students.id AS student_id, 
    # students.name AS student 
    # FROM cohorts 
    # JOIN students 
    # ON cohorts.id = students.cohort_id
    # WHERE cohorts.id = $1;';
    # Returns an array of cohort objects each with the array of Student object.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1

# Get all the cohorts with their students

cohort_repository = CohortRepository.new
cohort = cohort_repository.find_with_students(1)
cohort.id # => 1
cohort.name # => 'June 22'
cohort.starting_date # => '2022-07-22'
cohort.students.first.id # => 1
cohort.students.first.name # => 'Maria'
cohort.students.last.id # => 2
cohort.students.last.name # => 'Shaun'
cohort.students.length # => 2
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_directory_2_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_student_directory_2.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

