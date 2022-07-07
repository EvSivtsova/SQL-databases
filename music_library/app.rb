# file: app.rb
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library')

music_library = AlbumRepository.new

music_library.all.each do |album|
  puts "#{album.id}. #{album.title}, #{album.release_year} by #{album.artist_id}"
end
