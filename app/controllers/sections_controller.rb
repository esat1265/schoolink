class SectionsController < ApplicationController
  def show
    @sections = current_user.sections
  end


end
