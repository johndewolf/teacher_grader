require 'CSV'
require 'pry'

class GradeReader
  def initialize(file)
    @file = file
  end

  def import_students
    student_roster = []
    CSV.foreach(@file) do |row|
      last_name = row[0]
      first_name = row[1]
      grades = row[2..-1].map {|grade| grade.to_i}
      student_roster << Student.new(last_name, first_name, grades)
    end
    student_roster
  end
end

class Student
  attr_reader :last_name, :first_name, :grades

  def initialize(last_name, first_name, grades)
    @last_name = last_name
    @first_name = first_name
    @grades = grades
  end

  def average_score
    @grades.inject(:+) / @grades.count
  end
end

reader = GradeReader.new('students.csv')
students = reader.import_students
students.each do |student|
  puts "Last Name: #{student.last_name}"
  puts "First Name: #{student.first_name}"
  puts "Test Scores: " + student.grades
  # puts student.grades
  puts "Average Score: #{student.average_score}"
  puts "____________________"
end




