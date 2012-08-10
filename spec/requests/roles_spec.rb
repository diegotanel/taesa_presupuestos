#encoding: utf-8

require 'spec_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

describe "Roles" do
	describe "link para cambio de rol" do
		before do
			@user = Factory(:user)
		end

		it "como usuario básico" do
			integration_sign_in(@user)
			visit user_path(@user)
			response.should_not have_selector("a", :href => role_path(@user), :content => "Cambiar rol")
		end
		
		describe "como administrador" do
			before do
				@admin = Factory(:user, :email => "admin@example.com", :admin => true)
				integration_sign_in(@admin)
			end

			describe "fallido" do
				describe "último administrador" do
					before do
						visit user_path(@admin)
						click_link "Cambiar rol"
					end

					it "debe retonar al perfil del usuario" do
						response.should render_template('show')
					end

					it "debe mostrar un mensaje" do
						flash[:error].should =~ /último administrador/i
					end
				end
			end

			describe "exitoso" do
				before do
					visit user_path(@user)
				end

				it "debe tener el link" do
					response.should have_selector("a", :href => role_path(@user), :content => "Cambiar rol")	
				end			

				it "debe cambiar el rol" do
					click_link "Cambiar rol"
					@usuarioActualizado = User.find(@user)
					@usuarioActualizado.admin?.should be_true
				end

				it "debe actualizar la etiquieta con el nuevo rol" do
					click_link "Cambiar rol"
					response.should have_selector('div', :content => 'Administrador')
				end

				it "debe aparecer un mensaje indicando a que rol se actualizo" do
					click_link "Cambiar rol"
					flash[:success].should =~ /Se ha actualizado su rol a/i
				end
			end
		end
	end
	DatabaseCleaner.clean
end