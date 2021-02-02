namespace :admin do
  desc "Creata admin account by rake"
  task :create, [:name, :email] => [:environment] do |_t, args|
    u = User.create!(name: args[:name],
                    email: args[:email],
                    role: 2, avatar: "admin_img")
    puts "#{u.name} with id:#{u.id} had been admin this page."
  end
end
