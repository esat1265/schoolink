require 'faker'

Grade.destroy_all
puts 'All grades destroyed'
Course.destroy_all
puts 'All courses destroyed'
Section.destroy_all
puts 'All sections destroyed'
Chatroom.destroy_all
puts 'All chatrooms destroyed'
Message.destroy_all
puts 'All messages destroyed'
Teacher.destroy_all
puts 'All teachers destroyed'
Student.destroy_all
puts 'All students destroyed'
Parent.destroy_all
puts 'All parents destroyed'
User.destroy_all
puts 'All users destroyedd'

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

positive_teacher_comments = [
  "This student has shown a remarkable improvement in understanding the core concepts of the course. Their dedication to homework and class participation has significantly contributed to their success.",
  "Despite initial challenges, the student has demonstrated a strong commitment to learning and has actively sought out additional resources. Their effort in group projects has been particularly commendable.",
  "The student consistently exhibits a high level of curiosity and engagement with the subject matter, which is reflected in their thoughtful questions and contributions to class discussions.",
  "You have clearly grasped the main concepts of the chapter, as reflected in your detailed responses. Continuing to delve into the details could further enrich your understanding.",
  "Your analysis in question 3 was particularly insightful. However, be sure to proofread your answers for minor calculation errors that might slip through.",
  "I was impressed by your ability to link theory to practical examples. Try to maintain this approach in future assignments to strengthen your understanding.",
  "It's evident you put a lot of effort into this assignment. Taking more time to plan your answers could help you structure your arguments more effectively.",
  "You've demonstrated a good grasp of the subject overall, but there are a few key concepts you seem to have misunderstood. I recommend reviewing Chapter 5 to solidify your understanding.",
  "Your creativity in approaching the questions is commendable. Focusing more on the given guidelines will make your responses even more aligned with exam expectations.",
  "I'm encouraged by the progress you've made since our last exam. Continuing to practice the challenging problems will help improve your grades.",
  "You have a solid understanding of the basics, but there were a few careless mistakes. A bit more focus could easily increase your score.",
  "Your response to question 2 demonstrates excellent critical thinking. Applying this same depth of analysis to all questions could maximize your score.",
  "It seems you struggled with some of the more advanced concepts introduced in this exam. Feel free to come see me during office hours for a more detailed explanation.",
  "Your innovative approach to problem-solving is commendable. Try to pair this creativity with a stronger adherence to foundational principles for even better results.",
  "You've shown a keen understanding of the thematic elements in the literature we've studied. Deepening your analysis with more textual evidence will enhance your arguments.",
  "The organization of your essay was exceptional, making your arguments clear and compelling. Continue to refine your thesis statements for greater impact.",
  "I appreciate the effort you put into researching your topic. In future, ensure your sources are more current to reflect the latest findings and discussions in the field.",
  "Your participation in class discussions is highly valuable and adds depth to our conversations. I encourage you to bring this level of engagement into your written work as well.",
  "You have a natural talent for mathematical reasoning. Focusing on detailed solution steps will help you avoid minor errors and improve your accuracy.",
  "Your project shows a lot of potential. Next time, consider using more diverse tools and techniques to further explore and present your findings.",
  "It's clear you've dedicated a lot of time to understanding this subject. Applying these concepts to real-world scenarios in your answers could provide even more insight.",
  "Your enthusiasm for the subject shines through in your work. Balancing this passion with critical evaluation of opposing viewpoints will make your arguments more robust.",
  "You've made significant progress in your writing skills. Paying closer attention to grammar and punctuation will polish your work and make your ideas stand out more clearly.",
]

negative_teacher_comments = [
  "You seem to have overlooked key instructions for the assignment. Let's work on following guidelines more closely.",
  "I noticed a pattern of simple mistakes that could be avoided with more careful review. Double-checking your work can greatly improve your accuracy.",
  "Your engagement in class discussions has been minimal. Participating more actively can enhance your understanding of the subject.",
  "The structure of your essay was challenging to follow. Organizing your thoughts more clearly will help convey your arguments effectively.",
  "There's a tendency in your work to rely on generalizations. Providing specific examples can strengthen your analysis.",
  "I observed a lack of critical analysis in your paper. Evaluating different perspectives can enrich your conclusions.",
  "Your mathematical solutions often skip important steps. Including more detail can make your reasoning clearer to others.",
  "There was a noticeable absence of effort in completing this project to its full potential. Investing more time and thought can lead to better outcomes.",
  "You've shown a reluctance to explore beyond surface-level information. Diving deeper into topics can enhance your understanding and interest.",
  "The relevance of some of your sources was questionable. Ensuring your research is pertinent and up-to-date will improve the credibility of your work.",
  "Your contributions to group work have been lacking. Being more proactive and collaborative can enhance both your experience and that of your peers.",
  "I've noticed a pattern of late submissions. Managing your time more effectively can alleviate stress and improve the quality of your work.",
  "Your responses in exams tend to be superficial. Taking time to elaborate on your answers can demonstrate a deeper comprehension of the material.",
  "There's room to improve in how you articulate your thoughts. Practicing clear and concise communication can greatly benefit your verbal and written work.",
  "You often seem unprepared for class. Reviewing materials beforehand can make a significant difference in your engagement and learning.",
  "There's a hesitancy to ask questions when you're unsure. Remember, seeking clarification is a key part of the learning process.",
  "Your application of theory to practical examples is often missing. Bridging this gap can make your understanding of concepts more solid and applicable.",
  "The accuracy of your scientific experiments needs attention. Being meticulous in your approach can lead to more reliable and valid results.",
  "You tend to settle for the first idea that comes to mind. Taking the time to explore multiple solutions can foster more creativity and innovation.",
  "There's a noticeable reliance on others for answers during group activities. Striving for independence in your learning will build confidence and knowledge.",]

8.times do |n|
  teacher = Teacher.create!(
    email: "teacher#{n+1}@example.com",
    password: "alain4ever",
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
100.times do |n|
  first__name = Faker::Name.first_name
  last__name = Faker::Name.last_name

  parent = Parent.create!(
    email: "#{first__name[0].downcase}.#{last__name.downcase}@slink.ch",
    password: "alain4ever",
    first_name: first__name,
    last_name: last__name,
    phone_number: "076 #{rand(100..999)} #{rand(10..99)} #{rand(10..99)}"
  )

  Student.create!(
    email: "student#{n+1}@example.com",
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: parent.last_name,
    type: "Student",
    section: Section.all.sample,
    parent: parent
  )
  puts "Parent #{n} and student #{n} created."
end

puts "____________Create 30 grades per student"
Student.all.each do |student|
  courses = student.section.courses.sample(5)
  puts "Creating grades for student #{student.first_name}"

  courses.each do |course|
    chapter_number = 1
    day = rand(25..180)

    6.times do |n|
      grade_value = (rand(1.0..6.0) * 2).round / 2
      comment = grade_value > 3 ? positive_teacher_comments.sample : negative_teacher_comments.sample
      Grade.create(
        course_id: course.id,
        grade: grade_value,
        date: Date.today - day,
        exam_name: "#{course.name} Chapter #{chapter_number}",
        comment: comment,
        student_id: student.id
      )
      chapter_number += 1
      day -= 25
    end
  end
end
