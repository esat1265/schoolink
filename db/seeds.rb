require 'faker'

puts 'Delete data'
Section.destroy_all
Grade.destroy_all
Course.destroy_all
Teacher.destroy_all
Student.destroy_all
Parent.destroy_all
User.destroy_all

puts "Create 10 sections"
Section.create(name: "4A")
Section.create(name: "4B")
Section.create(name: "5A")
Section.create(name: "5B")
Section.create(name: "6A")
Section.create(name: "6B")
Section.create(name: "7A")
Section.create(name: "7B")
Section.create(name: "8A")
Section.create(name: "8B")

puts "____________Create 5 teachers per section"
sections = Section.all
sections.each do |section|
  5.times do |n|
    Teacher.create(
      email: "teacher#{n+1}@example.com",
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
  parent = Parent.create(
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
  student = Student.create(
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


puts "____________Create 20 courses"
20.times do |n|
  Course.create(
    section_id: Section.pluck(:id).sample,
    name: Faker::Company.industry,
    teacher_id: Teacher.pluck(:id).sample
  )
  puts "Course #{n+1} created"
end

puts "____________Create 60 grades"
60.times do |n|
  Grade.create(
    course_id: Course.pluck(:id).sample,
    grade: (rand(1.0..6.0) * 2).round / 2,
    date: random_date = Date.today - rand(1..365),
    exam_name: Faker::Dessert.topping,
    comment: Faker::Hipster.paragraph(sentence_count: 2),
    student_id: Student.pluck(:id).sample
  )
  puts "Grades #{n+1} created"
end
