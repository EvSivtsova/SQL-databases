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


# Perform a SQL query on the database and get the result set.
# sql = 'SELECT cohorts.id AS cohort_id, cohorts.name AS cohort, cohorts.starting_date, students.id AS student_id, students.name AS student FROM cohorts JOIN students ON cohorts.id = students.cohort_id WHERE cohorts.id = 1;'

# result = DatabaseConnection.exec_params(sql, [])

# # Print out each record from the result set .
# result.each do |record|
#   p record
# end