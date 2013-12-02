require 'pry'
class GradeReader
  def initialize(file)
    @file = file
  end

  def import_students
      student_roster = []
      grades_count = []
      CSV.foreach(@file) do |row|
        last_name = row[0]
        first_name = row[1]
        grades = row[2..-1].map {|grade| grade.to_f}
        student_roster << Student.new(last_name, first_name, grades)
        grades_count << grades.length
      end
    if grades_count.all? {|x| x == grades_count[0]} == false
      puts "Not all students have same number of grades"
      abort
    else
      student_roster
    end
  end
end
