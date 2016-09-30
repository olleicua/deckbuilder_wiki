class Deck < ApplicationRecord
  has_many :deck_inclusions

  FORMATS = %w( commander legacy vintage casual pauper modern standard )

  validates :name, presence: true

  def list
    cards = []
    deck_inclusions.each do |inclusion|
      inclusion.quantity.times do
        cards << inclusion.card
      end
    end
    cards
  end

  def commander
    MTG::Card.find(commander_id) if commander_id.present?
  end
end
