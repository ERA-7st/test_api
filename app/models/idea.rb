class Idea < ApplicationRecord

  validates :body, :category_id, presence: true
  belongs_to :category

end
