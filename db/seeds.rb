# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, # { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', # movie: movies.first)
#
#
Admin.create!(
  name: 'Admin',
  email: 'admin@gmail.com',
  cpf: '07644271481',
  password: '123123',
  password_confirmation: '123123'
)

Employee.create!(
  name: 'Funcionario 1',
  email: 'f1@mail.com',
  cpf: '07644271481',
  cellphone: '83888888888',
  password: '123123',
  password_confirmation: '123123'
)

Employee.create!(
    name: 'Funcionario 2',
    email: 'f2@mail.com',
    cpf: '07644271482',
    cellphone: '83888888888',
    password: '123123',
    password_confirmation: '123123'
)

Customer.create!(
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

1.upto 15 do |n|
  Agenda.create!(
    name: "Agenda #{n}",
    user_id: Employee.first.id
  )
end

1.upto 15 do |n|
  Activity.create!(
    name: "Atividade #{n}",
    description: "Descrição da atividade #{n}",
    user_id: Employee.first.id,
    customer_name: Customer.first.name,
    customer_id: Customer.first.id,
    status: :not_started,
    activity_type: :attendance,
    agenda: Agenda.first
  )
end

16.upto 26 do |n|
  Activity.create!(
    name: "Atividade #{n}",
    description: "Descrição da atividade #{n}",
    user_id: Employee.first.id,
    customer_name: Customer.first.name,
    customer_id: Customer.first.id,
    status: :not_started,
    activity_type: :attendance,
    agenda: Agenda.second
  )
end

27.upto 32 do |n|
  Activity.create!(
    name: "Atividade #{n}",
    description: "Descrição da atividade #{n}",
    user_id: Employee.second.id,
    customer_name: Customer.second.name,
    customer_id: Customer.second.id,
    status: :not_started,
    activity_type: :attendance,
    agenda: Agenda.third
  )
end