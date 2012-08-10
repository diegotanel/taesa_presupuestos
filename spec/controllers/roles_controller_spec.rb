#encoding: utf-8

require 'spec_helper'

describe RolesController do
	describe "PUT 'update'" do
		describe "authentication of update roles" do
			before do
				@user = Factory(:user)
			end

			describe "for non-signed-in users" do
				it "should deny access to 'update'" do
					put :update, :id => @user, :user => {}
					response.should redirect_to(signin_path)
				end
			end
		end

		describe "for signed-in users" do

			before(:each) do
				@user = Factory(:user)
				test_sign_in(@user)
			end

			describe "usuario básico" do
				it "no debe poder acceder" do
					put :update, :id => @user
					response.should redirect_to(root_path)
				end
			end

			describe "como administrador" do
				before do
					@user.toggle!(:admin)
				end

				describe "failure" do
					it "el usuario a actualizar es no existe" do
						@ultimoUsuario = User.last
						@idInexistente = @ultimoUsuario.id + 1
						put :update, :id => @idInexistente
						@usuarioNulo = assigns(:user)
						@usuarioNulo.should be_nil
						response.should redirect_to(users_path)
					end

					it "es el último administrador" do
						put :update, :id => @user
						@usuarioActualizado = assigns(:user)
						@usuarioActualizado.admin?.should be_true
					end
				end

				describe "success" do
					before do
						@usuario_a_actualizar_el_rol = Factory(:user, :name => "Bob", :email => "another@example.com")
					end

					it "actualizar el rol del usuario" do
						put :update, :id => @usuario_a_actualizar_el_rol
						@usuarioActualizado = assigns(:user)
						@usuarioActualizado.admin?.should be_true
					end

					it "refrescar la vista perfil" do
						put :update, :id => @usuario_a_actualizar_el_rol
						response.should redirect_to(@usuario_a_actualizar_el_rol)
					end
				end
			end
		end
	end
end