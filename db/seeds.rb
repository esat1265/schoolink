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

courses = [
  "French", "English", "German", "Maths", "Physics",
  "Biology", "Chemistry", "IT", "Sport", "Geography",
  "History","Economy", "Music", "Philosophy", "Civic education"
]

Section.all.each_with_index do |section, index|
  teacher = Teacher.create!(
    email: "teacher#{index+1}@example.com",
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
  )

  created_courses = []
  5.times do
    random_course = (courses - created_courses).sample
    created_courses.push(random_course)
    teacher.courses.create!(section: section, name: random_course)
  end
  puts "Teacher #{index} in section created"
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
   Student.create!(
      email: "student#{n+1}@example.com",
      password: "password",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      type: "Student",
      section: Section.all.sample,
      parent: parent
    )
    puts "Student #{n+1} created"
end


puts "____________Create 30 grades per student"
students = Student.all
students.each do |student|
  courses = student.section.courses.sample(5)

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
      puts "Grades #{n+1} for student #{student.first_name} created"
    end
  end
end
