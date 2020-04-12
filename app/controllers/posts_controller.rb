class PostsController < ApplicationController
  def index
    @posts = Post.all.order(datetime: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(title: params[:title], datetime: params[:datetime], site: params[:site], comment: params[:comment], assess: params[:assess].to_i)
    @post.save
    redirect_to("/posts/index")
  end

  def show
    @post = Post.find_by(id: params[:id])
  end
end
