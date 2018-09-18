class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @articles = []
    else
      @articles = Article.search params[:q]
    end
  end

  def autocomplete
    render json: Article.search(params[:q], {
      fields: ["title^5", "text"],
      match: :word_start,
      limit: 10,
      load: false,
      misspellings: {below: 5}
    }).map(&:title)
  end
end
