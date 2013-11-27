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
    FinalGrade.new(@grades).calc_average_score
  end

  def letter_grade
    FinalGrade.new(@grades).calc_letter_grade
  end

end

class FinalGrade
  def initialize(grades)
    @grades = grades
  end

  def calc_average_score
    @grades.inject(:+) / @grades.count
  end

  def calc_letter_grade
    if calc_average_score >= 90
      'A'
    elsif calc_average_score>= 80
      'B'
    elsif calc_average_score >= 70
      'C'
    elsif calc_average_score >= 60
      'D'
    else
      'F'
    end
  end
end

# class GradeSummary
#   def initialize(grades)
#     @grades = grades
#   end

#   def average_grades
#     @grades.count
#   end
# end


reader = GradeReader.new('students.csv')
students = reader.import_students

students.each do |student|
  puts "Last Name: #{student.last_name}"
  puts "First Name: #{student.first_name}"
  puts student.grades
  puts student.average_score
  puts student.letter_grade
  puts "____________________"
end




