# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@user = User.create!(:name => "admin", :email => "admin@admin.com",
                     :password => "123456", :password_confirmation => "123456")
@user.toggle!(:admin)

valid_attributes = {:user_id => @user, :valor => 1}
@cotizacion_peso_dolar = CotizacionPesoDolar.create! valid_attributes
@saldo_bancario = SaldoBancario.create! valid_attributes
