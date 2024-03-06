class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def parent_dashboard

  end

  def teacher_dashboard
    @sections = current_user.sections
    @courses = Course.includes(:section).where(teacher_id: current_user.id)
    @notifications = [
      "#{rand(1..100)}% of homeworks returned",
      "Student project due Friday",
      "Presentations tomorrow, prepare accordingly",
     " Discuss behavior problem after class",
      "Progress reports ready for distribution",
      "Tutoring room 203.",
      "Display artwork in hallway",
      "Council elections",
      "Mentoring program seeking volunteers",
      "Distribute project guidelines",
     " Dress code reminder: No hats in class",
      "Achievement celebration assembly",
    ]
    @todos = [
      "Summer outing presentation",
      "Faculty meeting, 3:00 PM, staff lounge",
      "Submit Q2 grades by EOD",
      "Field trip: New departure time, 9:30 AM",
      "Parent-Teacher sign-ups",
      "School closed tomorrow (weather)",
      "New curriculum materials ready for pickup",
      "Staff development day",
      "Picture day, dress code",
      "Emergency drill this morning",
      "Tech maintenance this afternoon",
      "Congrats Science Olympiad team!",
      "Special assembly, 9:00 AM",
      "Review revised calendar",
      "Supply requests",
      "Report cards in main office",
      "Staff luncheon today, 12:00 PM, cafeteria",
      "Parking lot construction ongoing",
      "Health briefing, 8:30 AM",
      "Volunteers needed for school fair",
      "Teacher of the Year nominations due",
    ]
  end
end
