require_relative 'GradeReader'
require_relative 'Students'
require_relative 'FinalGrade'
require_relative 'GradeSummary'
require 'csv'

begin
puts "Please enter filename"
filename = gets.chomp
end until File.exists?(filename) && filename[-4..-1] == '.csv'


reader = GradeReader.new(filename)
students = reader.import_students

CSV.open('report.csv', "w") do |csv|
  students.sort_by!{|student| student.last_name}
  students.each do |student|
    csv << [student.last_name, student.first_name, student.average_score, student.letter_grade]
  end
end

puts "Class Average: #{GradeSummary.new(students).class_average}"
puts "Lowest Class Average: #{GradeSummary.new(students).class_min}"
puts "Highest Class Average: #{GradeSummary.new(students).class_max}"
puts "Class Standard Deviation: #{GradeSummary.new(students).standard_div}"
puts "Report on Grades was written"
