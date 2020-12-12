class Ride < ActiveRecord::Base #ApplicationRecord
    belongs_to :user
    belongs_to :attraction

    # validates :user_id, presence: true
    # validates :attraction_id, presence: true

    def take_ride
        #byebug
        if user.tickets < attraction.tickets && user.height >= attraction.min_height
            "Sorry. You do not have enough tickets to ride the #{attraction.name}."
        elsif user.tickets >= attraction.tickets && user.height < attraction.min_height
            "Sorry. You are not tall enough to ride the #{attraction.name}."
        elsif user.tickets < attraction.tickets && user.height < attraction.min_height
            "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
        elsif user.tickets >= attraction.tickets && user.height >= attraction.min_height
            #byebug
            user.tickets = user.tickets - attraction.tickets
            user.happiness = user.happiness + attraction.happiness_rating
            user.nausea = user.nausea + attraction.nausea_rating
            user.save
        end
    end

end
