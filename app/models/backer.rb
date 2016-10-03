# Our model for backers
class Backer < ApplicationRecord
  belongs_to :project

  # Given names should be alphanumeric and allow underscores or dashes.
  # Given names should be no shorter than 4 characters but no longer than 20 characters.
  validates :given_name, presence: true,
                         length: { minimum: 4, maximum: 20 },
                         format: { with: /\A[A-Za-z0-9\-_]+\z/,
                                   message: 'must be alphanumeric (underscores or dashes are allowed)' }

  # Credit card numbers may vary in length, up to 19 characters.
  # Credit card numbers will always be numeric.
  # Card numbers should be validated using Luhn-10.
  # Cards that fail Luhn-10 will display an error.
  # Cards that have already been added will display an error.
  validates :credit_card_number, length: { maximum: 19 },
                                 uniqueness: true,
                                 numericality: { only_integer: true },
                                 luhn: true

  # Backing dollar amounts should accept both dollars and cents.
  # Backing dollar amounts should NOT use the $ currency symbol to avoid issues with shell escaping.
  validates :backing_amount, presence: true,
                             numericality: { greater_than: 0 }
end
