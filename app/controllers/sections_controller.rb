class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :add_grade, :create_grades]

  def show
    @sections = current_user.sections
    @section = Section.find(params[:id])
    @students = @section.students
  end

  def add_grade
    @section = Section.find(params[:id])
  end

  def show_grades
    @section = Section.find(params[:id])
    @students = @section.students
  end


  def create_grades
    course_id = params[:section][:course_id]
    exam_name = params[:exam_name]
    date = params[:date]

    grades_params = params[:grades].permit!.to_h

    grades_params.each do |student_id, grade_data|
      Grade.create(
        course: Course.find(course_id),
        student: Student.find(student_id),
        grade: grade_data['grade'],
        comment: grade_data['comment'],
        exam_name: exam_name,
        date: date
      )
    end
    redirect_to section_path(@section), notice: 'Grades were successfully created.'
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end

  def grades_params
    params.require(:grades).permit(grades: [:grade, :comment])[:grades]
  end
end
