class WelcomeController < ApplicationController
  def index
  	@users = User.order('email ASC')
  end
end
