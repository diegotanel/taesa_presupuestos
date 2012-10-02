# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121002183950) do

  create_table "bancos", :force => true do |t|
    t.string   "detalle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "canales_de_solicitud", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clientes", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cotizaciones_peso_dolar", :force => true do |t|
    t.integer  "user_id"
    t.integer  "valor_cents",    :default => 0, :null => false
    t.string   "valor_currency",                :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "cotizaciones_peso_dolar", ["user_id"], :name => "index_cotizaciones_peso_dolar_on_user_id"

  create_table "empresas", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "medios_de_pago", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "motivos_de_baja_presupuestaria", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "productos_trabajos", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "proveedores", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rubros", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "saldos_bancario", :force => true do |t|
    t.integer  "user_id"
    t.integer  "valor_cents",    :default => 0, :null => false
    t.string   "valor_currency",                :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "saldos_bancario", ["user_id"], :name => "index_saldos_bancario_on_user_id"

  create_table "solicitantes", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "admin",           :default => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
