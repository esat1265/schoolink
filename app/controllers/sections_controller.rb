class SectionsController < ApplicationController
  def show
    @sections = current_user.sections
    @section = Section.find(params[:id])
    @students = @section.students
  end

  def add_grade
    @section = Section.find(params[:id])

  end

end
