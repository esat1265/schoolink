class StudentsController < ApplicationController
  def show
    @student = Student.find(params[:id])
    @section = @student.section
    @courses = @student.grades.includes(:course).map(&:course).uniq
    @latest_grades = @student.grades.order(created_at: :desc).limit(3)

    if params[:course_id].present?
      @grades = @student.grades.includes(:course).where(course_id: params[:course_id]).order(date: :desc)
    else
      @grades = @student.grades.includes(:course).order(date: :desc)
    end
  end
end
