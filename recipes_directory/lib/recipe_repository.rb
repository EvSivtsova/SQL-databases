require_relative "./recipe"

class RecipeRepository
  def all
    sql = 'SELECT id, name, cooking_time, rating FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql, [])
    recipes = []
    result_set.each do |record|
      recipe = record_to_recipe_object(record)
      recipes << recipe
    end
    return recipes
  end

  def find(id)
    sql = 'SELECT id, name, cooking_time, rating FROM recipes WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    return nil if result_set.to_a.length == 0
    record = result_set[0]
    recipe = record_to_recipe_object(record)
    return recipe
  end  

  private

  def record_to_recipe_object(record)
    recipe = Recipe.new
    recipe.id = record['id'].to_i
    recipe.name  = record['name'] 
    recipe.cooking_time = record['cooking_time'].to_i
    recipe.rating = record['rating'].to_i
    return recipe
  end  
end