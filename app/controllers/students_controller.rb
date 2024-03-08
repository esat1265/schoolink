class StudentsController < ApplicationController
  def show
    @student = Student.find(params[:id])
    @section = @student.section
  end
end
