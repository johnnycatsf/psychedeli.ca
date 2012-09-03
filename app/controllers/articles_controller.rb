class ArticlesController < ApplicationController
  respond_to :html

  # Index page. Show snippets of all articles.
  #
  # GET /
  def index
    @articles = Article.all
    respond_with @articles
  end

  # Show the full article.
  #
  # GET /:category/:year/:month/:day/:hyphenated_title
  def show
    @article = Article.find with_filename_by params[:id]

    if @article.present? and @article.layout == 'post'
      respond_with @article
    else
      render 'errors/not_found', status: 404
    end
  end

private
  def with_filename_by id
    tokens = id.split "/"
    tokens[1..-1].join "/", "-" # omit category
  end
end
