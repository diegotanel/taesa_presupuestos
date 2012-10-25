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

ActiveRecord::Schema.define(:version => 20121025182636) do

  create_table "bancos", :force => true do |t|
    t.string   "detalle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bancos_empresas", :id => false, :force => true do |t|
    t.integer "banco_id",   :null => false
    t.integer "empresa_id", :null => false
  end

  add_index "bancos_empresas", ["banco_id", "empresa_id"], :name => "index_bancos_empresas_on_banco_id_and_empresa_id"

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

  create_table "cotizaciones_peso_dolar_historico", :force => true do |t|
    t.integer  "user_id",                                 :null => false
    t.integer  "cotizacion_peso_dolar_id",                :null => false
    t.integer  "valor_cents",              :default => 0, :null => false
    t.string   "valor_currency",                          :null => false
    t.datetime "created_at",                              :null => false
  end

  add_index "cotizaciones_peso_dolar_historico", ["cotizacion_peso_dolar_id"], :name => "index_cpdh_on_cotizacion_peso_dolar_id"
  add_index "cotizaciones_peso_dolar_historico", ["user_id"], :name => "index_cotizaciones_peso_dolar_historico_on_user_id"

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

  create_table "partidas_contable", :force => true do |t|
    t.datetime "fecha_actual",                                    :null => false
    t.datetime "fecha_de_vencimiento",                            :null => false
    t.integer  "empresa_id",                                      :null => false
    t.integer  "banco_id",                                        :null => false
    t.integer  "solicitante_id",                                  :null => false
    t.integer  "canal_de_solicitud_id",                           :null => false
    t.integer  "rubro_id",                                        :null => false
    t.integer  "importe_cents",                    :default => 0, :null => false
    t.string   "importe_currency",                                :null => false
    t.string   "tipo_de_movimiento",                              :null => false
    t.integer  "referente_id",                                    :null => false
    t.string   "referente_type",                                  :null => false
    t.string   "detalle"
    t.integer  "producto_trabajo_id",                             :null => false
    t.integer  "medio_de_pago_id",                                :null => false
    t.string   "estado",                                          :null => false
    t.integer  "motivo_de_baja_presupuestaria_id"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "partidas_contable", ["banco_id"], :name => "index_partidas_contable_on_banco_id"
  add_index "partidas_contable", ["canal_de_solicitud_id"], :name => "index_partidas_contable_on_canal_de_solicitud_id"
  add_index "partidas_contable", ["empresa_id"], :name => "index_partidas_contable_on_empresa_id"
  add_index "partidas_contable", ["medio_de_pago_id"], :name => "index_partidas_contable_on_medio_de_pago_id"
  add_index "partidas_contable", ["motivo_de_baja_presupuestaria_id"], :name => "index_partidas_contable_on_motivo_de_baja_presupuestaria_id"
  add_index "partidas_contable", ["producto_trabajo_id"], :name => "index_partidas_contable_on_producto_trabajo_id"
  add_index "partidas_contable", ["referente_id"], :name => "index_partidas_contable_on_referente_id"
  add_index "partidas_contable", ["referente_type"], :name => "index_partidas_contable_on_referente_type"
  add_index "partidas_contable", ["rubro_id"], :name => "index_partidas_contable_on_rubro_id"
  add_index "partidas_contable", ["solicitante_id"], :name => "index_partidas_contable_on_solicitante_id"

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

  create_table "saldos_bancario_historico", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "saldo_bancario_id",                :null => false
    t.integer  "valor_cents",       :default => 0, :null => false
    t.string   "valor_currency",                   :null => false
    t.datetime "created_at",                       :null => false
  end

  add_index "saldos_bancario_historico", ["saldo_bancario_id"], :name => "index_saldos_bancario_historico_on_saldo_bancario_id"
  add_index "saldos_bancario_historico", ["user_id"], :name => "index_saldos_bancario_historico_on_user_id"

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
