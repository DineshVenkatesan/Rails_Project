class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    # @post = Post.new
    @post = current_user.posts.build
  end

  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, :notice => "Post Created Successfully!"
    else
      redirect_to new_post_path, :notice => "Something wents wrong, must fill all the fields"
    end
  end

  def show
      @post = Post.find(params[:id])
      @comments = Post.find(params[:id]).comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, :notice => "Post Updated Successfully!"
    else
      redirect_to edit_post_path , :notice => "Something wents wrong, must fill all the fields"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, :notice => "Post has been deleted"
  end

  def mypost
    @posts = Post.all
    @post_count = 0
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :user_id, :image)
  end

end