# View articles posted to the blog in app/documents/articles. Also
# functioning as the homepage of the site, this controller renders
# out blog pages in a Rails-like manner, while using the powerful
# backend tools and +ActionView+ enhancements given to us by
# +ActiveCopy+.
class ArticlesController < ApplicationController
  respond_to :html, :rss
  caches_page :index, :category, :show, gzip: :best_speed

  # Index page. Show snippets of all articles.
  #
  # GET /
  def index
    @articles = ArticleDecorator.decorate Article.latest
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
    @with_id = if params[:id].present?
      params[:id]
    else
      article_id_from_params
    end
    @article = ArticleDecorator.decorate Article.find(@with_id)

    if @article.present? and not @article.nil?
      if use_layout?
        @articles = Article.latest
        respond_with @article
      else
        render partial: @article
      end
    else
      render 'errors/not_found', status: 404
    end
  end

  def comments
    @article = ArticleDecorator.decorate Article.find(params[:id])
    @articles = Article.latest

    if @article.present?
      @show_comments = true
      render partial: 'comments', layout: false
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

  def article_id_from_params
    [
      params[:year],
      params[:month],
      params[:day],
      params[:title]
    ].join("-")
  end
end
