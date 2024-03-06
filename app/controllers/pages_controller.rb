class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def parent_dashboard
    @parent = current_user
    @student = @parent.students.first
    @section = @student.section
    @courses = @section.courses
    @student_grades = @student.grades

    @grades_by_course = @student_grades.group_by { |grade| grade.course }
  end

  def teacher_dashboard
    @sections = current_user.sections
  end


end
