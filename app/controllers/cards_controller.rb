class CardsController < ApplicationController
  def query
    cards = MTG::Card.where(name: params[:q]).all.group_by(&:name).map do |name, cards|
      {
        name: name,
        versions: cards.map do |card|
          {
            image: card.image_url,
            multiverse_id: card.multiverse_id
          }
        end
      }
    end

    render json: cards
  end
end
