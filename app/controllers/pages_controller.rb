class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def parent_dashboard
    @parent = current_user
    @student = @parent.students.first
    @student_grades = @student.grades
    @section = @student.section
    # @section_teachers = @section.teachers

  end

  def teacher_dashboard
    @sections = current_user.sections
  end
end
