# file: app.rb
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect('music_library')

class Application
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name) 
    @io = io 
    @album_repository = album_repository 
    @artist_repository = artist_repository
  end

  def run
    @io.puts "Welcome to the music library manager!\n\n"
    user_choice = nil
    until (user_choice == "1" || user_choice == "2")
      @io.puts "What would you like to do?\n1 - List all albums\n2 - List all artists"
      user_choice = @io.gets.chomp
    end
    case user_choice 
      when "1"
        @album_repository.all.each do |album|
          puts "* #{album.id} - #{album.title}"
        end
      when "2"
        @artist_repository.all.each do |artist|
          puts "* #{artist.id} - #{artist.name} - #{artist.genre}"
        end
    end
  end
end  

if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end