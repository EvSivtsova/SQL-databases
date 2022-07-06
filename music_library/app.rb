# file: app.rb
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library')

music_library = AlbumRepository.new

music_library.all.each do |album|
  p album
end

p music_library.find_by_title('Doolittle')
p music_library.find_by_id(5)

p music_library.create('Ludwig van Beethoven: Symphonien 1-9', '2019', '1')

p music_library.update(17, 5)
p music_library.delete(18)