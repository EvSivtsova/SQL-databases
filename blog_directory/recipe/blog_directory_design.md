{{BLOG DIRECTORY}} # Two Tables Design Recipe Template

## 1. Extract nouns from the user stories or specification

```
# USER STORY:
# (analyse only the relevant part - here the final line).

As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.
```

```
Nouns:

posts, posts' title, posts' content, comments, comments' content, comments' author_name
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties           |
| --------------------- | ---------------------|
| posts                 | title, content       |
| comments              | author_name, content |

1. Name of the first table (always plural): `posts` 

    Column names: `title`, `content`

2. Name of the second table (always plural): `comments` 

    Column names: `author_name`, `content`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
Table: posts
id: SERIAL
title: text
content: text

Table: comments
id: SERIAL
content: text
author_name: text
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
1. Can one post have many comments? YES
2. Can one comment have many posts? NO

-> Therefore,
-> A post HAS MANY comments
-> A comment BELONGS TO a post


Comment -> many to one -> Post

-> Therefore, the foreign key is on the comments table (post_id).
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql

-- file: seeds_blog_directory.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
);

-- Then the table with the foreign key first.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  author_name text,
  content text,
-- The foreign key name is always {other_table_singular}_id
  post_id int,
  constraint fk_post foreign key(post_id) references posts(id)
);

## 5. Create the tables.

```bash
psql -h 127.0.0.1 blog_directory <  seeds_blog_directory.sql
```
## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/student_repository.rb)
class PostRepository
end

# Table name: comments

# Model comment
# (in lib/comment.rb)
class Comment
end

```
## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
  attr_accessor :id, :title, :content, :comments

  def initialize
    @comments = []
  end
end

# Table name: comments

# Model comment
# (in lib/comment.rb)
class Comment
  # Replace the attributes by your own columns.
  attr_accessor :id, :author_name, :content, :post_id
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Gets a post with associated comments
  # One argument: post_id (number)
  def find_with_comments(post_id)
    # Executes the SQL query:
    # SELECT posts.title, posts.content, comments.id, comments.author_name, comments.content 
        # FROM posts
        # JOIN comments
        # ON posts.id = comments.post_id
        # WHERE posts.id = $1;
    # Returns a single Post object with an array of associated Comment objects.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all students

repo = StudentRepository.new

students = repo.all

students.length # =>  2

students[0].id # =>  1
students[0].name # =>  'David'
students[0].cohort_name # =>  'April 2022'

students[1].id # =>  2
students[1].name # =>  'Anna'
students[1].cohort_name # =>  'May 2022'

# 2
# Get a single student

repo = StudentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'April 2022'

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
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
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
