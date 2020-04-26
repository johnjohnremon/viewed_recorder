class PostsController < ApplicationController
  def index
    @posts = Post.all
    @column_names = @posts.column_names
    @sort = "datetime"
    @order = "desc"

    template_order = '%<sort>s %<order>s'
    template_filter = '%<filter>s = ?'

    if @column_names.include?(params[:sort]) && (params[:order] == "asc" || params[:order] == "desc") then
      @sort = params[:sort]
      @order = params[:order]
    end

    @posts = @posts.all.order(template_order % {sort: @sort, order: @order})

    if @column_names.include?(params[:filter]) && params[:keyword] then
      @filter = params[:filter]
      @keyword = params[:keyword]
      if params[:filter] == "assess" && @keyword =~ /^[0-9]+$/ then
        @posts = Post.where(template_filter % {filter: @filter}, @keyword.to_i)
      else
        @posts = Post.where(template_filter % {filter: @filter}, @keyword)
      end
      @posts = @posts.order(template_order % {sort: @sort, order: @order})
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
