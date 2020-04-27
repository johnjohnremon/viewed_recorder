class PostsController < ApplicationController
  def index
    @posts = Post.all
    @column_names = @posts.column_names
    @sort = "datetime"
    @order = "desc"

    if @column_names.include?(params[:sort]) && (params[:order] == "asc" || params[:order] == "desc") then
      @sort = params[:sort]
      @order = params[:order]
    end

    if @order == "desc" then
      @posts = @posts.all.order("#{ActiveRecord::Base.connection.quote_column_name(@sort)} desc")
    else
      @posts = @posts.all.order("#{ActiveRecord::Base.connection.quote_column_name(@sort)}")
    end

    if @column_names.include?(params[:filter]) && params[:keyword] then
      @filter = params[:filter]
      @keyword = params[:keyword]
      if params[:filter] == "assess" && @keyword =~ /^[0-9]+$/ then
        @posts = Post.where("#{ActiveRecord::Base.connection.quote_column_name(@filter)} = ?", @keyword.to_i)
      else
        @posts = Post.where("#{ActiveRecord::Base.connection.quote_column_name(@filter)} = ?", @keyword)
      end
      if @order == "desc" then
        @posts = @posts.order("#{ActiveRecord::Base.connection.quote_column_name(@sort)} desc")
      else
        @posts = @posts.all.order("#{ActiveRecord::Base.connection.quote_column_name(@sort)}")
      end
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
