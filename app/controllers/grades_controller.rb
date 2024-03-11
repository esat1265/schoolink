class GradesController < ApplicationController
  def index
    @parent = current_user
    @student = @parent.student
    @section = @student.section
    @courses = @section.courses
    @student_grades = @student.grades.order(:created_at)

    # Group grades by course
    @grades_by_course = @student_grades.group_by(&:course)
    # max number of grades
    @grades_count_by_course = @grades_by_course.transform_values(&:count)
    @max_grades = @grades_count_by_course.max_by { |_, count| count }.last

    # Calculate averages of each course
    @averages_by_course = {}
    @grades_by_course.each do |course, grades|
      total_grades = grades.length
      total_points = grades.reduce(0) { |sum, grade| sum + grade.grade }
      average_grade = (total_points / total_grades.to_f).round(1)
      formatted_average_grade = sprintf("%.1f", average_grade)
      @averages_by_course[course] = average_grade
    end

    # Calculate averages of course entire class
    @courses = @section.courses
    @grades_by_courses = {}

    @courses.each do |course|
      grades = Grade.where(course: course)
      course_average = grades.average(:grade).round(1)
      formatted_course_grade = sprintf("%.1f", course_average)
      @grades_by_courses[course] = course_average
    end

  end

  def show
    @grade = Grade.find(params[:id])
  end
end
