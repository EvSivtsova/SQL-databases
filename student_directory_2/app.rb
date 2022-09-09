# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/cohort_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('student_directory_2')

repo = CohortRepository.new
cohort = repo.find_with_students(1)

puts "#{cohort.name} cohort starting on #{cohort.starting_date}:"
cohort.students.map do |student|
  puts "#{student.id}. #{student.name}"
end