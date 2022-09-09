# require_relative '../app.rb'
# require 'pg'

# def reset_albums_table
#   seed_sql = File.read('spec/seeds_music_library.sql')
#   connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library' })
#   connection.exec(seed_sql)
# end

# describe Application do
#   before(:each) do 
#     reset_albums_table
#   end

#   it "prints and returns the list of albums if option '1' is chosen" do
#     database_name = DatabaseConnection.connect('music_library') 
#     album_repository = AlbumRepository.new
#     artist_repository = ArtistRepository.new
#     io = double(:io)
#     expect(io).to receive(:puts).with("Welcome to the music library manager!\n\n") #.ordered
#     expect(io).to receive(:puts).with("What would you like to do?\n1 - List all albums\n2 - List all artists").ordered
#     expect(io).to receive(:gets).with("1").ordered
#     # expect(io).to receive(:puts).with("* 1 - Doolittle\n* 2 - Surfer Rosa\n* 4 - Super Trouper\n* 5 - Bossanova\* 6 - Lover\n
#     #   * 7 - Folklore\n
#     #   * 8 - I Put a Spell on You\n
#     #   * 9 - Baltimore\n
#     #   * 10 - Here Comes the Sun\n
#     #   * 11 - Fodder on My Wings\n
#     #   * 3 - Waterloo\n
#     #   * 14 - Mezzanine\n
#     #   * 15 - The Fat of the Land\n
#     #   * 18 - Ludwig van Beethoven: Symphonien 1-9\n
#     #   * 17 - Ludwig van Beethoven: Symphonien 1-9\n").ordered 
#     app = Application.new(database_name, io, album_repository, artist_repository)
#     app.run
#   end
# end