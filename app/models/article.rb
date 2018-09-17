require 'elasticsearch/model'
class Article < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'text']
          }
        },
        highlight: {
          pre_tags: ['<em>'],
          post_tags: ['</em>'],
          fields: {
            title: {},
            text: {}
          }
        }
      }
    )
  end

  settings do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: :english
      indexes :text, type: :text, analyzer: :english
    end
  end
end
Article.import(force: true)
