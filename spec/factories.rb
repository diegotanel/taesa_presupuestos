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

Factory.define :cotizacion_peso_dolar_historico do |cotizacion|
  cotizacion.valor_cents 1356
  cotizacion.valor_currency "ARS"
  cotizacion.association :user
  cotizacion.association :cotizacion_peso_dolar
end

Factory.define :saldo_bancario do |cotizacion|
  cotizacion.valor_cents 1356
  cotizacion.valor_currency "ARS"
  cotizacion.association :user
end

Factory.define :saldo_bancario_historico do |cotizacion|
  cotizacion.valor_cents 1356
  cotizacion.valor_currency "ARS"
  cotizacion.association :user
  cotizacion.association :saldo_bancario
end

Factory.define :empresa do |empresa|
  empresa.detalle "TAESA"
end
