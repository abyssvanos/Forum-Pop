class PostPolicy < ApplicationPolicy

	attr_reader :user, :post
	
	def initialize(user, post)
		@user = user
		@post = post
	end

	def edit?
		user == post.user
	end

	def create?
		user.id == post.user_id
	end


	def destroy?
		user == post.user || user.admin == true
	end

end