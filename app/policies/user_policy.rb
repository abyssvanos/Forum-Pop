class UserPolicy < ApplicationPolicy
	
	def initialize(user, usermodel)
    @user = user
    @usermodel = usermodel
  end

	def edit?
		user == @usermodel || user.admin == true
	end

	def destroy?
	end


end
