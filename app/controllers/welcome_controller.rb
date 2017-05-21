class WelcomeController < ApplicationController
  #<%= @orders.errors.full_messages %>
  def index
    flash[:alert] = "this is alert"
    flash[:notice] = "this is notice"
    flash[:warning] = "this is warning"
  end
end
