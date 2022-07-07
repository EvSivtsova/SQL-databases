{{MUSIC LIBRARY}} Model and Repository Classes Design Recipe

2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_music_library.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

CREATE TABLE "public"."albums" 
    "id" SERIAL,
    "title" text,
    "release_year" int4,
    "artist_id" int4,

CREATE TABLE "public"."artists" 
    "id" SERIAL,
    "name" text,
    "genre" text,
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 music_library_test < seeds_music_library.sql
```

3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```ruby
# Table name: albums

# Model class
# (in lib/album.rb)
class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end

# Table name: artists

# Model class
# (in lib/artist.rb)
class Artist
end

# Repository class
# (in lib/artist_repository.rb)
class ArtistRepository
end
```

4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

``` ruby

# Table name: albums

# Model class
# (in lib/album.rb)

class Album
  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :release_year, :artist_id
end


# Table name: artists

# Model class
# (in lib/artist.rb)

class Artist
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :genre
end
```

5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: albums

# Repository class
# (in lib/album_repository.rb)

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;
    # Returns an array of Album objects.
  end

  # Gets a single record by its title
  # One argument: the title (string)
  def find_by_title(title)
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums WHERE title = $1;
    # Returns an array of Album objects with the same title.
  end
  
    # Gets a single record by its id
    # One argument: the id (int)
  def find_by_id(id)
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;
    # Returns one Album objects with the same id.    
  end

  # creates an Album object and adds it to the repository
  def create(new_album)
    # Executes the SQL query:
    # INSERT INTO albums (title, release_year, artist_id) VALUES($1, $2, $3);
    # Three arguments: the title (string), release_year (int), artist_id (int)
    # returns nothing
  end

  # updates an Album object
  def update(artist)
    # Executes the SQL query:   
    # 'UPDATE albums SET artist_id = $2 WHERE id = $1;
    # Two arguments: the id (int), artist_id (int)
    # returns nothing
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM albums WHERE id = $1;
    # One argument: the id (strinintg)
    # returns nothing
  end
end
```
```ruby
# Table name: artists

# Repository class
# (in lib/artist_repository.rb)

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;
    # Returns an array of Artist objects.
  end
end
```

6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# 1
# Get all albums

repo = AlbumRepository.new

albums = repo.all

albums.length # =>  12

albums[0].id # =>  1
albums[0].title # =>  'Doolittle'
albums[0].release_year # =>  1989
albums[0].artist_id # =>  1

albums[9].id # =>  10
albums[9].title # =>  'Here Comes the Sun'
albums[9].release_year # =>  1971
albums[9].artist_id # =>  4

# 2
# Get a single album by title

repo = AlbumRepository.new

albums = repo.find_by_title('Folklore')

albums[0].id # =>  7
albums[0].title # =>  'Folklore'
albums[0].release_year # =>  2020
albums[0].artist_id # =>  3

# 3
#Create an album
repo = AlbumRepository.new
album = Album.new
album.id = 13
album.title = 'The Fat of the Land'
album.release_year =  1997
album.artist_id =  5
repo.create(album)
albums = repo.all
albums #=> to include title: 'The Fat of the Land'

# 4 
# Update album's artist by its title
repo = AlbumRepository.new
album = repo.find_by_id('1')
album.album.title =  'NotDoolittle'
album.release_year =  2021
album.artist_id =  3
repo.update(album)
updated_album = repo.find_by_id('1')
updated_album.id # =>  1
updated_album.title # =>  'NotDoolittle'
updated_album.release_year # =>  2021
updated_album.artist_id # =>  3

# 5
# Deletes an album record from the data
repo = AlbumRepository.new
repo.delete('1')
albums = repo.all
albums.length # =>  11
repo.find_by_title('Doolittle') # => nil

```
Encode this example as a test.

7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/album_repository_spec.rb

def reset_albums_table
  seed_sql = File.read('spec/seeds_music_library.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  # (your tests will go here).
end


8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.