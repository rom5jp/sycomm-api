# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, # { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', # movie: movies.first)
#
#
admin = Admin.create!(
  name: 'Admin',
  email: 'admin@gmail.com',
  cpf: '07644271481',
  password: '123123',
  password_confirmation: '123123'
)
puts "Admin criado: #{admin.id}"

f1 = Employee.create!(
  name: 'Funcionario 1',
  email: 'f1@mail.com',
  cpf: '07644271481',
  cellphone: '83888888888',
  password: '123123',
  password_confirmation: '123123'
)
puts "Funcionario 1 criado: #{f1.id}"

f2 = Employee.create!(
    name: 'Funcionario 2',
    email: 'f2@mail.com',
    cpf: '07644271482',
    cellphone: '83888888888',
    password: '123123',
    password_confirmation: '123123'
)
puts "Funcionario 2 criado: #{f2.id}"

f3 = Employee.create!(
    name: 'Funcionario 3',
    email: 'f3@mail.com',
    cpf: '07644271483',
    cellphone: '83888888888',
    password: '123123',
    password_confirmation: '123123'
)
puts "Funcionario 3 criado: #{f3.id}"

c1 = Customer.create!(
  name: 'Cliente 1',
  email: 'cliente1@mail.com',
  cpf: '07644271481',
  password: '123123',
  password_confirmation: '123123',
  cellphone: '83996447337',
  registration: '123123',
  public_agency_id: PublicAgency.first.id,
  public_office_id: PublicOffice.first.id
)
puts "Cliente 1 criado: #{c1.id}"

c2 = Customer.create!(
  name: 'Cliente 2',
  email: 'cliente2@mail.com',
  cpf: '07644271482',
  password: '123123',
  password_confirmation: '123123',
  cellphone: '83996447337',
  registration: '123123',
  public_agency_id: PublicAgency.second.id,
  public_office_id: PublicOffice.second.id
)
puts "Cliente 2 criado: #{c2.id}"

c3 = Customer.create!(
  name: 'Cliente 3',
  email: 'cliente3@mail.com',
  cpf: '07644271483',
  password: '123123',
  password_confirmation: '123123',
  cellphone: '83996447337',
  registration: '123123',
  public_agency_id: PublicAgency.third.id,
  public_office_id: PublicOffice.third.id
)
puts "Cliente 3 criado: #{c3.id}"

1.upto 15 do |n|
  Agenda.create!(
    name: "Agenda #{n}",
    employee_id: Employee.first.id
  )
end

Agenda.first.customers << c1
Agenda.second.customers << c2
Agenda.third.customers << c3

Employee.first.agendas << Agenda.first
Employee.first.agendas << Agenda.second
Employee.second.agendas << Agenda.third
Employee.second.agendas << Agenda.fourth
f3.agendas << Agenda.where(name: 'Agenda 4').first
f3.agendas << Agenda.where(name: 'Agenda 5').first

1.upto 15 do |n|
  Activity.create!(
    name: "Atividade #{n}",
    description: "Descrição da atividade #{n}",
    employee_id: Employee.first.id,
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
    employee_id: Employee.first.id,
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
    employee_id: Employee.second.id,
    customer_name: Customer.second.name,
    customer_id: Customer.second.id,
    status: :not_started,
    activity_type: :attendance,
    agenda: Agenda.third
  )
end

33.upto 38 do |n|
  Activity.create!(
      name: "Atividade #{n}",
      description: "Descrição da atividade #{n}",
      employee_id: Employee.third.id,
      customer_name: Customer.third.name,
      customer_id: Customer.third.id,
      status: :not_started,
      activity_type: :attendance,
      agenda: Agenda.fourth
  )
end

puts "** Seeding finalizado **"