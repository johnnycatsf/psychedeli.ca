# View articles posted to the blog in app/documents/articles. Also
# functioning as the homepage of the site, this controller renders
# out blog pages in a Rails-like manner, while using the powerful
# backend tools and +ActionView+ enhancements given to us by
# +ActiveCopy+.
class ArticlesController < ApplicationController
  respond_to :html, :rss
  before_filter :block_rss, except: [:index]

  def index
    @search = search_params.any?
    @articles = Article.where(search_params).reverse
    @category = params[:category]
    @tag = "##{params[:tag]}".strip

    render 'empty' and return if @articles.nil? || @articles.empty?

    respond_with @articles
  end

  def show
    @article = ArticleDecorator.decorate Article.find by_article_id

    if @article.present? and not @article.nil?
      if use_layout?
        @articles = ArticleDecorator.decorate_collection \
          Article.latest
        respond_with @article
      else
        render partial: @article
      end
    else
      render 'errors/not_found', status: 404
    end
  end

  def comments
    @article = ArticleDecorator.decorate \
      Article.find(params[:id])
    @articles = ArticleDecorator.decorate_collection \
      Article.latest.decorate

    if @article.present?
      @show_comments = true
      render partial: 'comments', layout: false
    end
  end

private
  def search_params
    ActiveSupport::HashWithIndifferentAccess.new \
      params.select { |key,value| "#{key}" =~ /category|tag/ }
  end

  def use_layout?
    if request.xhr?
      false
    else
      true
    end
  end

  def by_article_id
    if params[:id].present?
      params[:id]
    else
      article_id_from_params
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

  def block_rss
    respond_with 'error', alert: "Invalid format.", status: 406 \
      and return if params[:format] == 'rss'
  end
end
