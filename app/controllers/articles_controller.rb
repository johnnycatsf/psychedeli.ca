# View articles posted to the blog in app/documents/articles. Also
# functioning as the homepage of the site, this controller renders
# out blog pages in a Rails-like manner, while using the powerful
# backend tools and +ActionView+ enhancements given to us by
# +ActiveCopy+.
class ArticlesController < ApplicationController
  respond_to :html
  caches_page :index, :category, :show, gzip: :best_speed

  # Index page. Show snippets of all articles.
  #
  # GET /
  def index
    @articles = ArticleDecorator.decorate \
      Article.all.reverse.select { |a| a.present? }
    respond_with @articles
  end

  # Category index. Show snippets of all articles in a specific
  # category.
  #
  # GET /gbs
  def category
    @category = params[:category]
    @articles = ArticleDecorator.decorate \
      Article.where(category: @category).all

    respond_with @articles
  end

  # Show the full article.
  #
  # GET /gbs/2000/01/01/happy-new-year
  def show
    @article = ArticleDecorator.decorate \
      Article.find params[:id]

    if @article.present? and not @article.nil?
      respond_with @article, layout: use_layout?
    else
      render 'errors/not_found', status: 404
    end
  end

private
  def use_layout?
    if request.xhr?
      false
    else
      true
    end
  end
end
