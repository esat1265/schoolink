require 'faker'

puts 'Delete data'
Section.destroy_all
Grade.destroy_all
Course.destroy_all
# User.destroy_all

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

puts "____________Create 5 teachers"
5.times do |n|
  User.create(
    email: "teacher#{n+1}@example.com",
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    type: "Teacher",
    section_id: Section.pluck(:id).sample
    )
  puts "Teacher #{n+1} created"
  end

  puts "____________Create 20 parents"
  20.times do |n|
    parent = User.create(
      email: "parent#{n+1}@example.com",
      password: "password",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_number: 123456789,
      type: "Parent"
    )
    puts "Parent #{n+1} created"

    # Assign each parent a random child/student

  end

  puts "____________Create 20 students"
20.times do |n|
  student = User.create(
    email: "student#{n+1}@example.com",
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    type: "Student",
    section_id: Section.pluck(:id).sample,
    parent_id: Parent.pluck(:id).sample
  )
  puts "Student #{n+1} created"
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
    grade: rand(1..6),
    date: random_date = Date.today - rand(1..365),
    exam_name: Faker::Dessert.topping,
    comment: Faker::Hipster.paragraph(sentence_count: 2),
    student_id: Student.pluck(:id).sample
  )
  puts "Grades #{n+1} created"
end
