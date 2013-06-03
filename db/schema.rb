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

ActiveRecord::Schema.define(:version => 20121204182324) do

  create_table "bancos", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "canales_de_solicitud", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "medios_de_pago", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clientes_proveedores", :force => true do |t|
    t.string   "detalle"
    t.boolean  "cliente",    :default => false, :null => false
    t.boolean  "proveedor",  :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "empresas", :force => true do |t|
    t.string   "detalle",    :null => false
    t.integer  "estado",     :null => false
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

  create_table "rubros", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "solicitantes", :force => true do |t|
    t.string   "detalle",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "partidas_contable", :force => true do |t|
    t.datetime "fecha_de_vencimiento",             :null => false
    t.integer  "empresa_id",                       :null => false
    t.integer  "banco_id"
    t.integer  "solicitante_id",                   :null => false
    t.integer  "canal_de_solicitud_id",            :null => false
    t.integer  "rubro_id",                         :null => false
    t.integer  "importe_cents",                    :null => false
    t.string   "importe_currency",                 :null => false
    t.integer  "valor_dolar_cents",                :null => false
    t.string   "valor_dolar_currency",             :null => false
    t.integer  "tipo_de_movimiento",               :null => false
    t.integer  "cliente_proveedor_id",             :null => false
    t.string   "detalle",                          :null => false
    t.integer  "producto_trabajo_id",              :null => false
    t.integer  "estado",                           :null => false
    t.integer  "motivo_de_baja_presupuestaria_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.index ["deleted_at"], :name => "index_partidas_contable_on_deleted_at"
    t.index ["motivo_de_baja_presupuestaria_id"], :name => "index_partidas_contable_on_motivo_de_baja_presupuestaria_id"
    t.index ["producto_trabajo_id"], :name => "index_partidas_contable_on_producto_trabajo_id"
    t.index ["cliente_proveedor_id"], :name => "index_partidas_contable_on_cliente_proveedor_id"
    t.index ["rubro_id"], :name => "index_partidas_contable_on_rubro_id"
    t.index ["canal_de_solicitud_id"], :name => "index_partidas_contable_on_canal_de_solicitud_id"
    t.index ["solicitante_id"], :name => "index_partidas_contable_on_solicitante_id"
    t.index ["banco_id"], :name => "index_partidas_contable_on_banco_id"
    t.index ["empresa_id"], :name => "index_partidas_contable_on_empresa_id"
    t.index ["motivo_de_baja_presupuestaria_id"], :name => "fk__partidas_contable_motivo_de_baja_presupuestaria_id"
    t.index ["producto_trabajo_id"], :name => "fk__partidas_contable_producto_trabajo_id"
    t.index ["cliente_proveedor_id"], :name => "fk__partidas_contable_cliente_proveedor_id"
    t.index ["rubro_id"], :name => "fk__partidas_contable_rubro_id"
    t.index ["canal_de_solicitud_id"], :name => "fk__partidas_contable_canal_de_solicitud_id"
    t.index ["solicitante_id"], :name => "fk__partidas_contable_solicitante_id"
    t.index ["banco_id"], :name => "fk__partidas_contable_banco_id"
    t.index ["empresa_id"], :name => "fk__partidas_contable_empresa_id"
    t.foreign_key ["banco_id"], "bancos", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_partidas_contable_banco_id"
    t.foreign_key ["canal_de_solicitud_id"], "canales_de_solicitud", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_partidas_contable_canal_de_solicitud_id"
    t.foreign_key ["cliente_proveedor_id"], "clientes_proveedores", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_partidas_contable_cliente_proveedor_id"
    t.foreign_key ["empresa_id"], "empresas", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_partidas_contable_empresa_id"
    t.foreign_key ["motivo_de_baja_presupuestaria_id"], "motivos_de_baja_presupuestaria", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_partidas_contable_motivo_de_baja_presupuestaria_id"
    t.foreign_key ["producto_trabajo_id"], "productos_trabajos", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_partidas_contable_producto_trabajo_id"
    t.foreign_key ["rubro_id"], "rubros", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_partidas_contable_rubro_id"
    t.foreign_key ["solicitante_id"], "solicitantes", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_partidas_contable_solicitante_id"
  end

  create_table "cancelaciones", :force => true do |t|
    t.integer  "partida_contable_id",  :null => false
    t.datetime "fecha_de_ingreso",     :null => false
    t.integer  "medio_de_pago_id",     :null => false
    t.integer  "importe_cents",        :null => false
    t.string   "importe_currency",     :null => false
    t.integer  "valor_dolar_cents",    :null => false
    t.string   "valor_dolar_currency", :null => false
    t.string   "observaciones"
    t.integer  "estado",               :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.index ["medio_de_pago_id"], :name => "index_cancelaciones_on_medio_de_pago_id"
    t.index ["partida_contable_id"], :name => "index_cancelaciones_on_partida_contable_id"
    t.index ["medio_de_pago_id"], :name => "fk__cancelaciones_medio_de_pago_id"
    t.index ["partida_contable_id"], :name => "fk__cancelaciones_partida_contable_id"
    t.foreign_key ["medio_de_pago_id"], "medios_de_pago", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_cancelaciones_medio_de_pago_id"
    t.foreign_key ["partida_contable_id"], "partidas_contable", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_cancelaciones_partida_contable_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "admin",           :default => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.index ["remember_token"], :name => "index_users_on_remember_token"
    t.index ["email"], :name => "index_users_on_email", :unique => true
  end

  create_table "cotizaciones_peso_dolar", :force => true do |t|
    t.integer  "user_id"
    t.integer  "valor_cents",    :null => false
    t.string   "valor_currency", :null => false
    t.datetime "updated_at",     :null => false
    t.index ["user_id"], :name => "index_cotizaciones_peso_dolar_on_user_id"
    t.index ["user_id"], :name => "fk__cotizaciones_peso_dolar_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_cotizaciones_peso_dolar_user_id"
  end

  create_table "cotizaciones_peso_dolar_historico", :force => true do |t|
    t.integer  "user_id",                                 :null => false
    t.integer  "cotizacion_peso_dolar_id",                :null => false
    t.integer  "valor_cents",              :default => 0, :null => false
    t.string   "valor_currency",                          :null => false
    t.datetime "fecha_de_alta",                           :null => false
    t.datetime "created_at",                              :null => false
    t.index ["cotizacion_peso_dolar_id"], :name => "index_cpdh_on_cotizacion_peso_dolar_id"
    t.index ["user_id"], :name => "index_cotizaciones_peso_dolar_historico_on_user_id"
    t.index ["cotizacion_peso_dolar_id"], :name => "fk__cotizaciones_peso_dolar_historico_cotizacion_peso_dolar_id"
    t.index ["user_id"], :name => "fk__cotizaciones_peso_dolar_historico_user_id"
    t.foreign_key ["cotizacion_peso_dolar_id"], "cotizaciones_peso_dolar", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_cotizaciones_peso_dolar_historico_cotizacion_peso_dolar_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_cotizaciones_peso_dolar_historico_user_id"
  end

  create_table "saldos_bancario", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.integer  "banco_id",       :null => false
    t.integer  "empresa_id",     :null => false
    t.integer  "valor_cents",    :null => false
    t.string   "valor_currency", :null => false
    t.integer  "estado",         :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.index ["banco_id", "empresa_id"], :name => "index_saldos_bancario_on_banco_id_and_empresa_id", :unique => true
    t.index ["user_id"], :name => "index_saldos_bancario_on_user_id"
    t.index ["empresa_id"], :name => "fk__saldos_bancario_empresa_id"
    t.index ["banco_id"], :name => "fk__saldos_bancario_banco_id"
    t.index ["user_id"], :name => "fk__saldos_bancario_user_id"
    t.foreign_key ["banco_id"], "bancos", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_saldos_bancario_banco_id"
    t.foreign_key ["empresa_id"], "empresas", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_saldos_bancario_empresa_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_saldos_bancario_user_id"
  end

  create_table "saldos_bancario_historico", :force => true do |t|
    t.integer  "user_id",           :null => false
    t.integer  "saldo_bancario_id", :null => false
    t.integer  "valor_cents",       :null => false
    t.string   "valor_currency",    :null => false
    t.datetime "fecha_de_alta",     :null => false
    t.datetime "created_at",        :null => false
    t.index ["saldo_bancario_id"], :name => "index_saldos_bancario_historico_on_saldo_bancario_id"
    t.index ["user_id"], :name => "index_saldos_bancario_historico_on_user_id"
    t.index ["saldo_bancario_id"], :name => "fk__saldos_bancario_historico_saldo_bancario_id"
    t.index ["user_id"], :name => "fk__saldos_bancario_historico_user_id"
    t.foreign_key ["saldo_bancario_id"], "saldos_bancario", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_saldos_bancario_historico_saldo_bancario_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_saldos_bancario_historico_user_id"
  end

end
