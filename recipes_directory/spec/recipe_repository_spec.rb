require 'recipe_repository'


def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end
  
describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  it "returns all Recipe objects " do
    repo = RecipeRepository.new
    recipes = repo.all
    
    expect(recipes.length).to eq 2
    
    expect(recipes[0].id).to eq 1
    expect(recipes[0].name).to eq 'Salad'
    expect(recipes[0].cooking_time).to eq 20
    expect(recipes[0].rating).to eq 5

    expect(recipes[1].id).to eq 2
    expect(recipes[1].name).to eq 'Soup'
    expect(recipes[1].cooking_time).to eq 40
    expect(recipes[1].rating).to eq 3
  end
  
  it "searches for and returns a Recipe object with a specific id" do
    repo = RecipeRepository.new

    recipe = repo.find(2)

    expect(recipe.id).to eq 2
    expect(recipe.name).to eq 'Soup'
    expect(recipe.cooking_time).to eq 40
    expect(recipe.rating).to eq 3
  end

  it "returns nil when searching for a Recipe object with a specific id if it's not in the data" do
    repo = RecipeRepository.new
    expect(repo.find(5)).to eq nil
  end
end