require 'faker'

Grade.destroy_all
puts 'All grades destroyed'
Course.destroy_all
puts 'All courses destroyed'
Section.destroy_all
puts 'All sections destroyed'
Teacher.destroy_all
puts 'All teachers destroyed'
Student.destroy_all
puts 'All students destroyed'
Parent.destroy_all
puts 'All parents destroyed'
User.destroy_all
puts 'All users destroyed'

puts "____________Create 10 sections"
sections = ["4A", "4B", "5A", "5B", "6A", "6B", "7A", "7B", "8A", "8B"]
sections.each do |section_name|
  Section.create(name: section_name)
  puts "Section #{section_name} created"
end

puts "____________Create 5 teachers per section"

courses = [
  "French", "English", "German", "Maths", "Physics",
  "Biology", "Chemistry", "IT", "Sport", "Geography",
  "History","Economy", "Music", "Philosophy", "Civic education"
]

8.times do |n|
  teacher = Teacher.create!(
    email: "teacher#{n+1}@example.com",
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
  )
  puts "Teacher #{n+1} created"
end

Section.all.each_with_index do |section, index|
  created_courses = []
  5.times do
    teacher = section.teachers.count > 3 ? section.teachers.sample : Teacher.all.sample
    random_course = (courses - created_courses).sample
    created_courses.push(random_course)
    section.courses.create!(teacher: teacher, name: random_course)
    puts "Course #{random_course} created with section #{section.name}"
  end
end

puts "____________Create 100 parents and 100 students"
20.times do |n|
  parent = Parent.create!(
    email: "parent#{n+1}@example.com",
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: "076 #{rand(0..9)} #{rand(0..9)} #{rand(0..9)} #{rand(0..9)} #{rand(0..9)} #{rand(0..9)} #{rand(0..9)}"
    )
   Student.create!(
      email: "student#{n+1}@example.com",
      password: "password",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      type: "Student",
      section: Section.all.sample,
      parent: parent
    )
end


puts "____________Create 30 grades per student"
students = Student.all
students.each do |student|
  courses = student.section.courses.sample(5)
  puts "Creating grades for student #{student.first_name}"

  courses.each do |course|

    6.times do |n|
      Grade.create!(
        course_id: course.id,
        grade: (rand(1.0..6.0) * 2).round / 2,
        date: random_date = Date.today - rand(1..365),
        exam_name: Faker::Dessert.topping,
        comment: Faker::Hipster.paragraph(sentence_count: 2),
        student_id: student.id
      )
    end
  end
end
