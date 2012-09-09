# View articles posted to the blog in app/documents/articles. Also
# functioning as the homepage of the site, this controller renders
# out blog pages in a Rails-like manner, while using the powerful
# backend tools and +ActionView+ enhancements given to us by
# +ActiveCopy+.
class ArticlesController < ApplicationController
  respond_to :html

  # Index page. Show snippets of all articles.
  #
  # GET /
  def index
    @articles = Article.all
    respond_with @articles
  end

  # Category index. Show snippets of all articles in a specific
  # category.
  #
  # GET /gbs
  def category
    @category = params[:category]
    @articles = Article.where(category: @category).all

    respond_with @articles
  end

  # Show the full article.
  #
  # GET /gbs/2000/01/01/happy-new-year
  def show
    @article = Article.find with_filename_by params[:id]

    if @article.present?
      respond_with @article
    else
      render 'errors/not_found', status: 404
    end
  end

private
  def with_filename_by id
    tokens = id.split "/"
    tokens[2..-1].join "-" # omit category
  end
end
