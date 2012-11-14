Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end

Factory.define :cotizacion_peso_dolar do |cotizacion|
  cotizacion.valor_cents 1356
  cotizacion.valor_currency "ARS"
  cotizacion.association :user
end

Factory.define :cotizacion_peso_dolar_historico do |cpdh|
  cpdh.valor_cents 1356
  cpdh.valor_currency "ARS"
  cpdh.association :user
  cpdh.association :cotizacion_peso_dolar
end

Factory.define :saldo_bancario do |sb|
  sb.valor_cents 1356
  sb.valor_currency "ARS"
  sb.association :user
end

Factory.define :saldo_bancario_historico do |sbh|
  sbh.valor_cents 1356
  sbh.valor_currency "ARS"
  sbh.association :user
  sbh.association :saldo_bancario
end

Factory.define :proveedor do |proveedor|
  proveedor.detalle "ASP"
end

Factory.define :empresa do |empresa|
  empresa.detalle "TAESA"
end

Factory.define :banco do |banco|
  banco.detalle "Banco Frances"
end

Factory.define :solicitante do |solicitante|
  solicitante.detalle "Fernando"
end

Factory.define :canal_de_solicitud do |canal|
  canal.detalle "Mail"
end

Factory.define :rubro do |rubro|
  rubro.detalle "Impuestos"
end

Factory.define :producto_trabajo do |producto_trabajo|
  producto_trabajo.detalle "Cosecha"
end

Factory.define :medio_de_pago do |medio_de_pago|
  medio_de_pago.detalle "Cheque"
end

Factory.define :motivo_de_baja_presupuestaria do |motivo_de_baja_presupuestaria|
  motivo_de_baja_presupuestaria.detalle "cumplida"
end

Factory.define :partida_contable do |pc|
  pc.fecha_actual DateTime.now
  pc.fecha_de_vencimiento DateTime.now
  pc.association :empresa
  pc.association :banco
  pc.association :solicitante
  pc.association :canal_de_solicitud
  pc.association :rubro
  pc.importe_cents "1356"
  pc.importe_currency "ARS"
  pc.tipo_de_movimiento "entrada"
  pc.referente Factory(:proveedor)
  pc.association :producto_trabajo
  pc.association :medio_de_pago
  pc.estado "Activo"
  pc.association :motivo_de_baja_presupuestaria
end

Factory.define :cancelacion do |cancelacion|
  cancelacion.association :partida_contable
  cancelacion.association :medio_de_pago
  cancelacion.fecha_de_ingreso Time.zone.parse("22/04/2012 22:41")
  cancelacion.importe_cents 672
  cancelacion.importe_currency "ARS"
  cancelacion.observaciones "cheque n 2314"
end