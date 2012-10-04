# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

ActiveSupport::Inflector.inflections do |inflect|
	inflect.irregular 'medio_de_pago', 'medios_de_pago'
	inflect.irregular 'motivo_de_baja_presupuestaria', 'motivos_de_baja_presupuestaria'
	inflect.irregular 'cotizacion_peso_dolar', 'cotizaciones_peso_dolar'
	inflect.irregular 'saldo_bancario', 'saldos_bancario'
	inflect.irregular 'canal_de_solicitud', 'canales_de_solicitud'
	inflect.irregular 'producto_trabajo', 'productos_trabajos'
	inflect.irregular 'proveedor', 'proveedores'
	inflect.irregular 'partida_contable', 'partidas_contable'
end