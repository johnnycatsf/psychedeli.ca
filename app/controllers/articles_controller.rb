# View articles posted to the blog in app/documents/articles. Also
# functioning as the homepage of the site, this controller renders
# out blog pages in a Rails-like manner, while using the powerful
# backend tools and +ActionView+ enhancements given to us by
# +ActiveCopy+.
class ArticlesController < ApplicationController
  respond_to :html
  caches_page :index, :category, :show, gzip: :best_speed
  before_filter :get_articles, except: [:category]

  # Index page. Show snippets of all articles.
  #
  # GET /
  def index
    @articles = Article.all.reverse.select { |a| a.present? }
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
    by_filename = if params[:id].present? and params[:id] =~ /\A([a-zA-Z]*)/
      params[:id].split('/')[1..-1].join('-')
    else
      params[:id]
    end
    @article = ArticleDecorator.decorate \
      Article.find by_filename

    if @article.present? and not @article.nil?
      if use_layout?
        respond_with @article
      else
        render partial: @article
      end
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

  def get_articles
    @articles = Article.all.reverse.select { |a| a.present? }
  end
end
