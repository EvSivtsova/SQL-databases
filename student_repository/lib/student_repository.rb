require_relative "./student"

class StudentRepository
  def all
    sql = 'SELECT id, name, cohort_id FROM students;'
    result_set = DatabaseConnection.exec_params(sql, [])
    students = []
    result_set.each do |record|
      student = record_to_movie_object(record)
      students << student
    end
    return students
  end

  def find(id)
    sql = 'SELECT id, name, cohort_id FROM students WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    return nil if result_set.to_a.length == 0
    record = result_set[0]
    student = record_to_movie_object(record)
    return student
  end

  def create(name, cohort_id)
    sql = 'INSERT INTO students (name, cohort_id) VALUES($1, $2);'
    sql_params = [name, cohort_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  def update(name, cohort_id)
    sql = 'UPDATE students SET cohort_id = $2 WHERE name = $1;'
    sql_params = [name, cohort_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

  end

  def delete(id)
    sql = 'DELETE FROM students WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  private

  def record_to_movie_object(record)
    student = Student.new
    student.id = record['id'].to_i
    student.name = record['name']
    student.cohort_id = record['cohort_id'].to_i
    return student
  end  
end