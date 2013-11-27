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
      grades = row[2..-1].map {|grade| grade.to_f}
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

class GradeSummary
  def initialize(roster)
    @roster = roster
  end

  def class_average
    scores = []
    @roster.each do |student|
      scores << student.average_score
    end
  scores.inject(:+) / scores.count
  end

  def class_min
    scores = []
    @roster.each do |student|
      scores << student.average_score
    end
    scores = scores.min
  end

  def class_max
    scores = []
    @roster.each do |student|
      scores << student.average_score
    end
    scores = scores.max
  end

  def standard_div
    mean = class_average
    scores = []
    @roster.each do |student|
      scores << student.average_score
    end
    variance = scores.inject(0) { |variance, x| variance += (x - mean) ** 2}
    return Math.sqrt(variance/(scores.size-1))
  end
end


reader = GradeReader.new('students.csv')
students = reader.import_students


CSV.open('gradesreport.csv', "w") do |csv|
  students.sort_by!{|student| student.last_name}
  students.each do |student|
    csv << [student.last_name, student.first_name, student.average_score, student.letter_grade]
  end
end

puts "Class Average: #{GradeSummary.new(students).class_average}"
puts "Lowest Class Average: #{GradeSummary.new(students).class_min}"
puts "Highest Class Average: #{GradeSummary.new(students).class_max}"
puts "Class Standard Deviation: #{GradeSummary.new(students).standard_div}"

puts
students.each do |student|
  puts "Last Name: #{student.last_name}"
  puts "First Name: #{student.first_name}"
  puts "Grades: "
  puts student.grades
  puts student.average_score
  puts student.letter_grade
  puts "____________________"
end




