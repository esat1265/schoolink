class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def parent_dashboard

    # Group grades by course
    @grades_by_course = current_user.student.grades.group_by(&:course)

    # Calculate averages of each course
    @averages_by_course = {}
    @grades_by_course.each do |course, grades|
      total_grades = grades.length
      total_points = grades.reduce(0) { |sum, grade| sum + grade.grade }
      average_grade = (total_points / total_grades.to_f).round(1)
      @averages_by_course[course] = average_grade
    end

    # Calculate averages of course entire class
    @courses = current_user.student.courses
    @grades_by_courses = {}

    @courses.each do |course|
      grades = Grade.where(course: course)
      course_average = grades.average(:grade).round(1)
      @grades_by_courses[course] = course_average
    end

    # Create array for piechart
    @grades_for_charts = @averages_by_course.map do |course, avg_student|
      {
        section: course.name,
        avg_student: (avg_student * 2.0).round / 2.0,
        avg_class: (@grades_by_courses[course] * 2.0).round / 2.0
      }
    end
  end

  def teacher_dashboard
    @sections = current_user.sections
    @courses = Course.includes(:section).where(teacher_id: current_user.id)
    @notifications = [
      "#{rand(1..100)}% of homeworks returned",
      "Student project due Friday",
      "Presentations tomorrow, prepare accordingly",
     " Discuss behavior problem after class",
      "Progress reports ready for distribution",
      "Tutoring room 203.",
      "Display artwork in hallway",
      "Council elections",
      "Mentoring program seeking volunteers",
      "Distribute project guidelines",
     " Dress code reminder: No hats in class",
      "Achievement celebration assembly",
    ]
    @todos = [
      "Emergency drill this morning",
      "Tech maintenance this afternoon",
      "Congrats Science Olympiad team!",
      "Parking lot construction ongoing",
      "Teacher of the Year nominations due",
    ]
  end
end
