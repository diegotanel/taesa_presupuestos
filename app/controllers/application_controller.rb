require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery
  include SessionsHelper
  include UsersHelper
  include RolesHelper
end
