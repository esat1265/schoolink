class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def parent_dashboard
    @parent = current_user
    @student = @parent.students.first
    @section = @student.section
    @courses = @section.courses
    @student_grades = @student.grades

    # Group grades by course
    @grades_by_course = @student_grades.group_by(&:course)

    # Calculate averages of each course
    @averages_by_course = {}
    @grades_by_course.each do |course, grades|
      total_grades = grades.length
      total_points = grades.reduce(0) { |sum, grade| sum + grade.grade }
      average_grade = (total_points / total_grades.to_f).round(1)
      @averages_by_course[course] = average_grade
    end

    # Calculate averages of course entire class
    @courses = @section.courses
    @grades_by_course = {}

    @courses.each do |course|
      grades = Grade.where(course: course)
      course_average = grades.average(:grade).round(1)
      @grades_by_course[course] = course_average
    end

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
