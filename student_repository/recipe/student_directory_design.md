{{STUDENT REPOSITORY}} Model and Repository Classes Design Recipe


2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_students.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO cohorts (name, starting_date) VALUES 
('April', '2022-04-22'),
('May', '2022-05-22'),
('June', '2022-06-22');


INSERT INTO students (name, cohort_id) VALUES 
('Ev', 'April 2022', '1'),
('Anna', 'May 2022', '2');
```
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 student_directory_test < seeds_students.sql
```

3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```ruby

# Table name: students

# Model class
# (in lib/student.rb)
class Student
end

# Repository class
# (in lib/student_repository.rb)
class StudentRepository
end
```

4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: students

# Model class
# (in lib/student.rb)

class Student
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cohort_id
end
```
5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class StudentRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_id FROM students;
    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_id FROM students WHERE id = $1;
    # Returns a single Student object.
  end

  # Creates a new Student object
  def create(student)
    # Executes the SQL query:
    # INSERT INTO students (name, cohort_id) VALUES('Mich', '3');
    # returns nothing
  end

  # Update a student object record
  def update(student)
    # Executes the SQL query:
    # UPDATE students SET cohort_id = '1' WHERE name = "Mich';
    # returns nothing
  end

  # Deletes a student object
  def delete(student)
    # Executes the SQL query:
    # DELETE FROM students WHERE id = '6';
    # returns nothing
  end
end
```

6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# 1
# Get all students

repo = StudentRepository.new

students = repo.all

students.length # =>  5

students[0].id # =>  1
students[0].name # =>  'Ev'
students[0].cohort_id # =>  1

students[2].id # =>  3
students[2].name # =>  'Anna'
students[2].cohort_id # =>  2

# 2
# Get a single student

repo = StudentRepository.new

student = repo.find(1)
students.id # =>  1
students.name # =>  'Maria'
students.cohort_id # =>  1

# 3
# Add a single student to the directory

repo = StudentRepository.new

student = repo.create('Mich', '3')
students = repo.all
students.length #=> 6
students.id # =>  6
students.name # =>  'Mich'
students.cohort_id # =>  3

# 4
# Update student's data

repo = StudentRepository.new
student = repo.update('Mich', '3')
students = repo.all
students.length #=> 6
students[5].id #=> 6
students[5].name #=>  'Mich'
students[5].cohort_id #=> 1

# 5

# Delete a record from the database
repo = StudentRepository.new
student = repo.delete(6)
students.all
students.repo.all # =>  5
students[0].id # =>  1
students[0].name # =>  'Ev'
students[0].cohort_id # =>  1

students[3].id # =>  3
students[3].name # =>  'Anna'
students[3].cohort_id # =>  2
students.find(6) # =>  nil
``` 
Encode this example as a test.

7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.