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
