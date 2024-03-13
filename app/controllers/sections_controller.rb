class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :add_grade, :create_grades]

  def show
    # Assurez-vous de définir @section avant de l'utiliser pour récupérer les étudiants
    @section = Section.find(params[:id])
    @sections = current_user.sections
    @students = @section.students

    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @students = @students.joins("LEFT JOIN users parents ON parents.id = users.parent_id")
                           .where("users.first_name ILIKE :search OR users.last_name ILIKE :search OR parents.first_name ILIKE :search OR parents.last_name ILIKE :search", search: search_term)
    end
    # Si params[:search] est vide ou non présent, @students contiendra déjà tous les étudiants de @section, donc aucun ajustement supplémentaire n'est nécessaire ici.
  end

  def add_grade
    @section = Section.find(params[:id])
    @sections = current_user.sections
    @students = @section.students
  end

  def show_grades
    @section = Section.find(params[:id])
    @students = @section.students
    @sections = current_user.sections
  end

  def create_grades
    course_id = params[:section][:course_id]
    exam_name = params[:section][:exam_name]
    date = params[:section][:date]

    grades_params = params[:grades].permit!.to_h

    grades_params.each do |student_id, grade_data|

      Grade.create(
        course: Course.find(course_id),
        student: Student.find(student_id),
        grade: grade_data['grade'],
        comment: grade_data['comment'],
        exam_name: exam_name,
        date: date,
      )
    end

    grades_params.each do |student_id, grade_data|

      std_id = student_id.to_i
      if params[:section]["grades[#{std_id}"].present?
        file_photo = params[:section]["grades[#{std_id}"]
        file = file_photo["photo"]["]"]
        cloudinary_response = Cloudinary::Uploader.upload(file.tempfile, folder: 'grades')
        cloudinary_url = cloudinary_response['secure_url']
      else
        cloudinary_url =""
      end

      find_grade = Student.find(student_id).grades.last
      find_grade.photo = cloudinary_url
      find_grade.save

    end
    redirect_to section_path(@section), notice: 'Grades were successfully created.'
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end

  def grades_params
    params.require(:grades).permit(grades: [:grade, :comment, :photo])[:grades]
  end
end
