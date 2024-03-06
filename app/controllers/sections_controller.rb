class SectionsController < ApplicationController
  def show
    @sections = current_user.sections
    @section = Section.find(params[:id]) # Trouvez la section par son id
    @students = @section.students
  end
end
