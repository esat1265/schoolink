class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def parent_dashboard

  end

  def teacher_dashboard
    @sections = current_user.sections
    @courses = Course.includes(:section).where(teacher_id: current_user.id)
  end
end
