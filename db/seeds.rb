require 'faker'

puts 'Delete data'
Course.destroy_all
Section.destroy_all
Grade.destroy_all
Teacher.destroy_all
Student.destroy_all
Parent.destroy_all
User.destroy_all

puts "____________Create 10 sections"
Section.create(name: "4A")
puts "Section 4A created"
Section.create(name: "4B")
puts "Section 4B created"
Section.create(name: "5A")
puts "Section 5A created"
Section.create(name: "5B")
puts "Section 5B created"
Section.create(name: "6A")
puts "Section 6A created"
Section.create(name: "6B")
puts "Section 6B created"
Section.create(name: "7A")
puts "Section 7A created"
Section.create(name: "7B")
puts "Section 7B created"
Section.create(name: "8A")
puts "Section 8A created"
Section.create(name: "8B")
puts "Section 8B created"

puts "____________Create 5 teachers per section"
sections = Section.all
sections.each do |section|
  5.times do |n|
    Teacher.create!(
      email: "teacher#{section.name}_#{n+1}@example.com",
      password: "password",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      section_id: section.id
      )
    puts "Teacher #{n+1} in section #{section.name} created"
  end
end


puts "____________Create 100 parents"
100.times do |n|
  parent = Parent.create!(
    email: "parent#{n+1}@example.com",
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: 123456789,
  )
  puts "Parent #{n+1} created"
end

puts "____________Create 1 student per parent (100 students in total) and add students in section"
parents = Parent.all
parents.each_with_index do |parent, index|
  student = Student.create!(
    email: "student#{index+1}@example.com",
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    type: "Student",
    section: Section.all.sample,
    parent_id: parent.id
  )
  puts "Student #{index+1} created"
end


puts "____________Create 15 courses"
courses = [
    "French", "English", "German", "Maths", "Physics",
    "Biology", "Chemistry", "IT", "Sport", "Geography",
    "History","Economy", "Music", "Philosophy", "Civic education"
  ]

15.times do |n|
  section = Section.all.sample
  teacher = Teacher.all.sample

  Course.create!(
    section: section,
    name: courses[n],
    teacher: teacher
  )
  puts "Course #{n+1} created"
end

puts "____________Create 30 grades per student"
students = Student.all
students.each do |student|
  30.times do |n|
    Grade.create!(
      course_id: Course.pluck(:id).sample,
      grade: (rand(1.0..6.0) * 2).round / 2,
      date: random_date = Date.today - rand(1..365),
      exam_name: Faker::Dessert.topping,
      comment: Faker::Hipster.paragraph(sentence_count: 2),
      student_id: student.id
    )
    puts "Grades #{n+1} for student #{student.first_name} created"
  end
end
