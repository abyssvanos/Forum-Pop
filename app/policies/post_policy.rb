class PostPolicy < ApplicationPolicy

	attr_reader :user, :post
	
	def initialize(current_user, post)
		@current_user = current_user
		@post = post
	end

	def edit?
		@current_user == post.user
	end

	def new?
		@current_user
	end

	def create?
		@current_user == post.user
	end


	def destroy?
		@current_user == post.user || current_user.admin == true
	end

end