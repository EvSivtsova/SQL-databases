require 'cohort_repository'

def reset_students_table
  seed_sql = File.read('spec/seeds_student_directory_2.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do 
    reset_students_table
  end

  it "returns the list of Cohort objects each with array of corresponding Student objects" do
    cohort_repository = CohortRepository.new
    cohort = cohort_repository.find_with_students(1)
    expect(cohort.id).to eq 1
    expect(cohort.name).to eq 'June 22'
    expect(cohort.starting_date).to eq '2022-07-22'
    expect(cohort.students.first.id).to eq 1
    expect(cohort.students.first.name).to eq 'Maria'
    expect(cohort.students.last.id).to eq 2
    expect(cohort.students.last.name).to eq 'Shaun'
    expect(cohort.students.length).to eq 2
  end
end