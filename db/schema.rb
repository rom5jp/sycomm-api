# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180717004900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "annotations"
    t.integer "status", default: 0, null: false
    t.integer "activity_type"
    t.integer "customer_id"
    t.string "customer_name"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "agenda_id"
    t.index ["agenda_id"], name: "index_activities_on_agenda_id"
    t.index ["employee_id"], name: "index_activities_on_employee_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street", null: false
    t.integer "number", null: false
    t.string "cep"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "neighborhood_id"
    t.bigint "city_id"
    t.bigint "state_id"
    t.index ["city_id"], name: "index_addresses_on_city_id"
    t.index ["neighborhood_id"], name: "index_addresses_on_neighborhood_id"
    t.index ["state_id"], name: "index_addresses_on_state_id"
  end

  create_table "agendas", force: :cascade do |t|
    t.string "name"
    t.date "start_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.index ["employee_id"], name: "index_agendas_on_employee_id"
  end

  create_table "agendas_customers", id: false, force: :cascade do |t|
    t.bigint "agenda_id", null: false
    t.bigint "customer_id", null: false
    t.index ["agenda_id", "customer_id"], name: "index_agendas_customers_on_agenda_id_and_customer_id"
    t.index ["customer_id", "agenda_id"], name: "index_agendas_customers_on_customer_id_and_agenda_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "state_id"
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "city_id"
    t.index ["city_id"], name: "index_neighborhoods_on_city_id"
  end

  create_table "public_agencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "public_offices", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.string "initials", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_seeds", force: :cascade do |t|
    t.string "name"
    t.string "registration"
    t.string "public_agency"
    t.string "public_office"
    t.string "cpf"
    t.string "simple_address"
  end

  create_table "users", force: :cascade do |t|
    t.string "registration"
    t.string "email"
    t.string "name", null: false
    t.string "surname"
    t.string "nickname"
    t.string "cpf"
    t.string "landline"
    t.string "cellphone"
    t.string "whatsapp"
    t.string "simple_address"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "public_agency_id"
    t.bigint "public_office_id"
    t.bigint "address_id"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.text "tokens"
    t.index ["address_id"], name: "index_users_on_address_id"
    t.index ["cpf"], name: "index_users_on_cpf"
    t.index ["email"], name: "index_users_on_email"
    t.index ["public_agency_id"], name: "index_users_on_public_agency_id"
    t.index ["public_office_id"], name: "index_users_on_public_office_id"
    t.index ["registration"], name: "index_users_on_registration"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "activities", "agendas"
  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "neighborhoods"
  add_foreign_key "addresses", "states"
  add_foreign_key "cities", "states"
  add_foreign_key "neighborhoods", "cities"
  add_foreign_key "users", "addresses"
  add_foreign_key "users", "public_agencies"
  add_foreign_key "users", "public_offices"
end
