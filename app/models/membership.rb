class Membership < ApplicationRecord
    belongs_to :gym
    belongs_to :client

    validates :gym_id, presence: true
    validates :client_id, presence: true
    validates :charge, presence: true

    validate :check_client_gym_uniqueness

    def check_client_gym_uniqueness
        if Membership.where(client_id: client_id, gym_id: gym_id).length > 0
            errors.add(:client, "can only have one membership with each gym")
        end
       
    end
end
