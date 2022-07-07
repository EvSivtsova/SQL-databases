require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

recipe_repository = RecipeRepository.new

recipe_repository.all.map do |recipe|
  p recipe
end  

p recipe_repository.find(1)
p recipe_repository.find(3)
