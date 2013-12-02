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
