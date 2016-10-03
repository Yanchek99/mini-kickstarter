# Model for projects
class Project < ApplicationRecord
  has_many :backers

  # Projects should be alphanumeric and allow underscores or dashes.
  # Projects should be no shorter than 4 characters but no longer than 20 characters.
  validates :name, presence: true,
                   length: { minimum: 4, maximum: 20 },
                   format: { with: /\A[A-Za-z0-9\-_]+\z/,
                             message: 'must be alphanumeric (underscores or dashes are allowed)' }

  # Target dollar amounts should accept both dollars and cents.
  # Target dollar amounts should NOT use the $ currency symbol to avoid issues with shell escaping.
  validates :target_amount, presence: true,
                            numericality: { greater_than: 0 }
end
