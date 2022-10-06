require_relative 'lib/database_connection'
require_relative 'lib/student_repository'


# We need to give the database name to the method `connect`.
DatabaseConnection.connect('students_test')

student_repository = StudentRepository.new

student_repository.all.each do |student|
  p student
end

p student_repository.find(2)

p student_repository.create('Da Vinci', 3)

p student_repository.update('Anna', 1)
p student_repository.delete(6)

