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
