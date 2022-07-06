require_relative "./album"

class AlbumRepository
    def all
      sql = 'SELECT id, title, release_year, artist_id FROM albums;'
      result_set = DatabaseConnection.exec_params(sql, [])
      albums = []
      result_set.each do |record|
        album = record_to_album_object(record)
        albums << album
      end
      albums
    end

    def find_by_title(title)
      sql ='SELECT id, title, release_year, artist_id FROM albums WHERE title = $1;'
      sql_params = [title]
      result_set = DatabaseConnection.exec_params(sql, sql_params)
      return nil if result_set.to_a.length == 0
      albums = []
      result_set.each do |record|
        album = record_to_album_object(record)
        albums << album
      end
      albums
    end
    
    def find_by_id(id)
      sql ='SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
      sql_params = [id]
      result_set = DatabaseConnection.exec_params(sql, sql_params)
      return nil if result_set.to_a.length == 0
      record = result_set[0]
      result =record_to_album_object(record)
      return result
    end

    def create(title, release_year, artist_id)
      sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES($1, $2, $3);'
      sql_params = [title, release_year, artist_id]
      DatabaseConnection.exec_params(sql, sql_params)
    end

    def update(id, artist_id)
      sql = 'UPDATE albums SET artist_id = $2 WHERE id = $1;'
      sql_params = [id, artist_id]
      DatabaseConnection.exec_params(sql, sql_params)
    end
    
    def delete(id)
      sql = 'DELETE FROM albums WHERE id = $1;'
      sql_params = [id]
      DatabaseConnection.exec_params(sql, sql_params)
    end

    private
    
    def record_to_album_object(record)
      album = Album.new
      album.id = record['id'].to_i
      album.title = record['title']
      album.release_year = record['release_year'].to_i
      album.artist_id = record['artist_id'].to_i
      return album
    end
  
  
  
  end