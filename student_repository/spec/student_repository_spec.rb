require 'student_repository'

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students_test' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  it "returns the list of all students" do
    repo = StudentRepository.new
    students = repo.all
    expect(students.length).to eq 5
    
    expect(students[0].id).to eq 1
    expect(students[0].name).to eq 'Ev'
    expect(students[0].cohort_id).to eq 1
    
    expect(students[2].id).to eq 3
    expect(students[2].name).to eq 'Anna'
    expect(students[2].cohort_id).to eq 2
  end

  it "selects Maria given her id" do
    repo = StudentRepository.new
    student = repo.find(2)
    expect(student.id).to eq 2
    expect(student.name).to eq 'Maria'
    expect(student.cohort_id).to eq 1
  end

  it "returns nil if the ID is not present in the table" do
    repo = StudentRepository.new
    student = repo.find(5674)
    expect(student).to eq nil
  end

  it "creates a new student record" do
    repo = StudentRepository.new
    student = repo.create('Mich', '3')
    students = repo.all
    expect(students.length).to eq 6
    expect(students[5].id).to eq 6
    expect(students[5].name).to eq 'Mich'
    expect(students[5].cohort_id).to eq 3
  end

  it "updates students records" do
    repo = StudentRepository.new
    student = repo.update('Ev', '3')
    students = repo.all
    expect(students.length).to eq 5
    expect(students[-1].id).to eq 1
    expect(students[-1].name).to eq 'Ev'
    expect(students[-1].cohort_id).to eq 3
  end

  it "deletes records from the database" do
    repo = StudentRepository.new
    student = repo.delete(1)
    students = repo.all
    expect(students.length).to eq 4
    expect(students[0].id).to eq 2
    expect(students[0].name).to eq 'Maria'
    expect(students[0].cohort_id).to eq 1
    expect(students[2].id).to eq 4
    expect(students[2].name).to eq 'Lucas'
    expect(students[2].cohort_id).to eq 3
  end
end