#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@admin = User.create!(:name => "admin", :email => "admin@admin.com",
                     :password => "123456", :password_confirmation => "123456")
@admin.toggle!(:admin)

@user = User.create!(:name => "ocarballa", :email => "ocarballa@taesa.com.ar",
                     :password => "123456", :password_confirmation => "123456")
@user.toggle!(:admin)

User.create!(:name => "arobles", :email => "arobles@taesa.com.ar",
                     :password => "123456", :password_confirmation => "123456")

@banco1 = Banco.create!(:detalle => "Banco Provincia de Buenos Aires")
@banco2 = Banco.create!(:detalle => "Citibank NA")

Empresa.create!(:detalle => "Ariste de Estrugamou SAAGI")
Empresa.create!(:detalle => "Lobiña SA")
@calmin = Empresa.create!(:detalle => "Calmin SA")
Empresa.create!(:detalle => "TAESA AGEISA")
Empresa.create!(:detalle => "Dalmon SA")
Empresa.create!(:detalle => "Chantaco SA")

Solicitante.create!(:detalle => "Fernando Buisan")
Solicitante.create!(:detalle => "Osvaldo Carballa")

CanalDeSolicitud.create!(:detalle => "Telefónico")
CanalDeSolicitud.create!(:detalle => "Mail")

Rubro.create!(:detalle => "Trabajos rurales")
Rubro.create!(:detalle => "Agroquímicos y fertilizantes")
Rubro.create!(:detalle => "Impuestos")
Rubro.create!(:detalle => "Hacienda")

ClienteProveedor.create!(:detalle => "Jukic")
ClienteProveedor.create!(:detalle => "ASP")
ClienteProveedor.create!(:detalle => "Ferrari")

ProductoTrabajo.create!(:detalle => "Cosecha")
ProductoTrabajo.create!(:detalle => "Combustible")
ProductoTrabajo.create!(:detalle => "Impuesto a las ganancias")

MedioDePago.create!(:detalle => "Cheque")
MedioDePago.create!(:detalle => "Cheque diferido")
MedioDePago.create!(:detalle => "Transferencia eléctronica")
MedioDePago.create!(:detalle => "Efectivo")

MotivoDeBajaPresupuestaria.create!(:detalle => "Cumplida")
MotivoDeBajaPresupuestaria.create!(:detalle => "No se realizará la compra o gasto")


valid_attributes = {:user_id => @user, :valor => Money.new(4, "ARS")}
@cotizacion_peso_dolar = CotizacionPesoDolar.create! valid_attributes
@saldo_bancario = SaldoBancario.create! valid_attributes.merge(:empresa_id => @calmin.id, :banco_id => @banco1.id)
@saldo_bancario = SaldoBancario.create! valid_attributes.merge(:empresa_id => @calmin.id, :banco_id => @banco2.id)
