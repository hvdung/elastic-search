class Article < ApplicationRecord
  searchkick word_start: [:title], suggest: [:title], highlight: [:title]
end
