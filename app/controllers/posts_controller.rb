class PostsController < ApplicationController
  def index
    @sort = "datetime"
    @order = "desc"
    if params[:sort] && params[:order] then
      @sort = params[:sort]
      @order = params[:order]
    end

    @posts = Post.all.order("#{@sort} #{@order}")

    if params[:filter] && params[:keyword] then
      @filter = params[:filter]
      @keyword = params[:keyword]
      if params[:filter] == "assess" && @keyword =~ /^[0-9]+$/ then
        @posts = Post.where("#{@filter} = ?", @keyword.to_i)
      else
        @posts = Post.where("#{@filter} = ?", @keyword)
      end
      @posts = @posts.order("#{@sort} #{@order}")
    end
    
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(title: params[:title], datetime: params[:datetime], site: params[:site], comment: params[:comment], assess: params[:assess].to_i)
    @post.save
    redirect_to("/posts/index")
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def editsave
    @post = Post.find_by(id: params[:id])
    @post.update_attributes(title: params[:title], datetime: params[:datetime], site: params[:site], comment: params[:comment], assess: params[:assess].to_i)
    redirect_to("/posts/index")
  end

  def delete
    @post = Post.find_by(id: params[:id])
    @post.delete
    redirect_to("/posts/index")
  end

  def show
    @post = Post.find_by(id: params[:id])
  end
end
