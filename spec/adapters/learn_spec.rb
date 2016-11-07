require_relative '../spec_helper.rb'

describe Adapters::Learn do
  it "returns a list of students by batch" do
    learn_adapter = Adapters::Learn.new
    students = learn_adapter.fetch_batch_students(432)
    expect(students.length).to eq(33)
  end

  it "knows the students completed lesson counts" do
    learn_adapter = Adapters::Learn.new
    student = learn_adapter.fetch_batch_students(432).first

    expect(student['completed_lessons_count']).to_not eq(nil)
    expect(student['completed_lessons_count']).to eq(130)
  end
end
