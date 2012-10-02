require 'spec_helper'

describe "Bancos" do
	describe "GET /bancos" do
		it "debe responder correctamente" do
			get bancos_path
			response.should be_success
		end
	end
end
