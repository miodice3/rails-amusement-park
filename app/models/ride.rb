class Ride < ActiveRecord::Base #ApplicationRecord
    belongs_to :user
    belongs_to :attraction

    # validates :user_id, presence: true
    # validates :attraction_id, presence: true

    # def take_ride
    #     #byebug
    #     if user.tickets < attraction.tickets && user.height >= attraction.min_height
    #         "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    #     elsif user.tickets >= attraction.tickets && user.height < attraction.min_height
    #         "Sorry. You are not tall enough to ride the #{attraction.name}."
    #     elsif user.tickets < attraction.tickets && user.height < attraction.min_height
    #         "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    #     elsif user.tickets >= attraction.tickets && user.height >= attraction.min_height
    #         #byebug
    #         user.tickets = user.tickets - attraction.tickets
    #         user.happiness = user.happiness + attraction.happiness_rating
    #         user.nausea = user.nausea + attraction.nausea_rating
    #         user.save
    #         "Thanks for riding the #{attraction.name}!"
    #     end
    # end

    def take_ride
        user_has_enough_tickets, user_is_tall_enough = user_meets_requirements
        if user_has_enough_tickets && user_is_tall_enough
          start_ride
        elsif user_is_tall_enough && !user_has_enough_tickets
          "Sorry. " + not_enough_tickets
        elsif !user_is_tall_enough && user_has_enough_tickets
          "Sorry. " + not_tall_enough
        elsif !user_is_tall_enough && !user_has_enough_tickets
          "Sorry. " + not_enough_tickets + " " + not_tall_enough
        end
      end
    
      def user_meets_requirements
        #byebug
        user_has_enough_tickets, user_is_tall_enough = false
        if self.user.tickets >= self.attraction.tickets
          user_has_enough_tickets = true
        end
        if self.user.height >= self.attraction.min_height
          user_is_tall_enough = true
        end
        return [user_has_enough_tickets, user_is_tall_enough]
      end
    
      def start_ride
        new_happiness = self.user.happiness + self.attraction.happiness_rating
        new_nausea = self.user.nausea + self.attraction.nausea_rating
        new_ticket_count = self.user.tickets - self.attraction.tickets
        self.user.update(
          :happiness => new_happiness,
          :nausea => new_nausea,
          :tickets => new_ticket_count
        )
        "Thanks for riding the #{self.attraction.name}!"
      end
    
      def not_enough_tickets
        "You do not have enough tickets to ride the #{self.attraction.name}."
      end
    
      def not_tall_enough
        "You are not tall enough to ride the #{self.attraction.name}."
      end

end
