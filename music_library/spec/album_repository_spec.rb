require 'album_repository'
require 'album'

def reset_albums_table
  seed_sql = File.read('spec/seeds_music_library.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end
  
describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  it "returns all the album records" do
    repo = AlbumRepository.new
    albums = repo.all
    expect(albums.length).to eq 12
    expect(albums[0].id).to eq 1
    expect(albums[0].title).to eq 'Doolittle'
    expect(albums[0].release_year).to eq 1989
    expect(albums[0].artist_id).to eq 1
    expect(albums[9].id).to eq 10
    expect(albums[9].title).to eq 'Here Comes the Sun'
    expect(albums[9].release_year).to eq 1971
    expect(albums[9].artist_id).to eq 4
  end

  it "returns an Album object (objects) by its title" do
    repo = AlbumRepository.new
    albums = repo.find_by_title('Folklore')
    expect(albums[0].id).to eq 7
    expect(albums[0].title).to eq 'Folklore'
    expect(albums[0].release_year).to eq 2020
    expect(albums[0].artist_id).to eq 3
  end

  it "returns nil if the Album with given title does not exist" do
    repo = AlbumRepository.new
    album = repo.find_by_title('Grease')
    expect(album).to eq nil
  end

  it " creates an Album instance and adds it to the database" do
    repo = AlbumRepository.new
    album = Album.new
    album.id = 1
    album.title = 'The Fat of the Land'
    album.release_year =  1997
    album.artist_id =  5
    repo.create(album)
    expect(repo.create(album)).to eq nil
    albums = repo.all
    expect(albums).to include(
      have_attributes(title: 'The Fat of the Land')
      )
  end
 
  it "updates artist_id for an Album object searched by its id" do
    repo = AlbumRepository.new
    album = repo.find_by_id(1)
    album.title = 'NotDoolittle'
    album.release_year = 2021
    album.artist_id = 3
    repo.update(album)
    expect(repo.update(album)).to eq nil
    updated_album = repo.find_by_id(1)
    expect(updated_album.id).to eq 1
    expect(updated_album.title).to eq 'NotDoolittle'
    expect(updated_album.release_year).to eq 2021
    expect(updated_album.artist_id).to eq 3
  end

  it "deletes an Album instance from the database by its id" do
    repo = AlbumRepository.new
    repo.delete('1')
    expect(repo.delete('1')).to eq nil
    albums = repo.all
    expect(albums.length).to eq 11
    expect(repo.find_by_title('Doolittle')).to eq nil
  end
end