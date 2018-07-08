# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, # { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', # movie: movies.first)
#
#
User.create!(name: 'Admin',
             email: 'admin@gmail.com',
             cpf: '07644271481',
             password: '123123',
             password_confirmation: '123123',
             type: 'Admin')
User.create!(name: 'Funcionario 1',
             email: 'f1@mail.com',
             cpf: '07644271481',
             cellphone: '83888888888',
             password: '123123',
             password_confirmation: '123123',
             type: 'Employee')
User.create!(
    name: 'Cliente 1',
    email: 'cliente1@mail.com',
    cpf: '07644271481',
    password: '123123',
    password_confirmation: '123123',
    type: 'Customer',
    cellphone: '83996447337',
    registration: 123123,
    public_agency_id: 1,
    public_office_id: 1
)

1.upto 10 do |n|
  Activity.create!(
      name: "Atividade #{n}",
      description: "Descrição da atividade #{n}",
      user_id: Employee.first.id,
      customer_name: Customer.first.name,
      customer_id: Customer.first.id,
      status: :not_started,
      activity_type: :attendance
  )
end