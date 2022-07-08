require_relative "./cohort"
require_relative "./student"

class CohortRepository
  def find_with_students(cohort_id)
    sql = 'SELECT cohorts.id AS cohort_id, 
                cohorts.name AS cohort, 
                cohorts.starting_date, 
                students.id AS student_id, 
                students.name AS student 
                FROM cohorts 
                JOIN students 
                ON cohorts.id = students.cohort_id
                WHERE cohorts.id = $1;'
    params = [cohort_id]
   
    result_set = DatabaseConnection.exec_params(sql, params)
    return nil if result_set.to_a.length == 0
    result = result_set[0]
    cohort = record_to_cohort(result)
    cohort.students
    result_set.each do |record|
      student = record_to_student(record)
      cohort.students << student
    end
    return cohort
  end

  private

  def record_to_cohort(record)
    cohort = Cohort.new
    cohort.id = record['cohort_id'].to_i
    cohort.name = record['cohort']
    cohort.starting_date = record['starting_date']
    cohort.students = []
    return cohort
  end 
  
  def record_to_student(record)
    student = Student.new
    student.id = record["student_id"].to_i
    student.name = record['student']
    return student
  end  
end