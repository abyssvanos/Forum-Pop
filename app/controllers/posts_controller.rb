class PostsController < ApplicationController
  include Pundit
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, only:[:edit, :create, :destroy]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order('user_id ASC')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    
  end

  # GET /posts/new
  def new
      if user_signed_in?
        @post = current_user.posts.build
      end
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
    authorize @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  # admin can delete every post
  # normal users only can delete their own posts
  def destroy
    authorize @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :content)
    end
end
