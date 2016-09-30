class DeckInclusion < ApplicationRecord
  belongs_to :deck

  validates :deck_id, presence: true
  validates :card_id, presence: true
  validates :quantity, presence: true

  def card
    @card ||= MTG::Card.find(card_id)
  end
end
