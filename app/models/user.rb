class User < ApplicationRecord
    has_many :rides
    has_many :attractions, through: :rides
    has_secure_password

    def mood
        happiness > nausea ? "happy" : "sad"
    end

end



    # def mood
    #     #byebug
    #     if @user.happiness > @user.nausea
    #         #@user.mood = "happy"
    #         return "happy"
    #     elsif @user.nausea < @user.happiness
    #         #@user.mood = "sad"
    #         return "sad"
    #     end
    # end