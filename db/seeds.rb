user = User.find_or_initialize_by(email: 'test@test.com')

unless user.id
  user.email = 'test@test.com'
  user.password = '123456abc@'

  user.save!
end

unless user.tasks.any?
  tasks = [
    { title: Faker::Hipster.sentence, user: user, deadline: Faker::Date.forward(days: rand(5..20)) },
    { title: Faker::Hipster.sentence, user: user, deadline: Faker::Date.forward(days: rand(5..20)) }
  ]

  tasks.each do |t|
    Task.create(t)
  end
end
