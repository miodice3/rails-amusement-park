class RidesController < ApplicationController

    def create
        #current_user
        ride = Ride.create(ride_params)
#        ride.user_id = current_user.id
        #ride.save
        #byebug
        message = ride.take_ride
        redirect_to user_path(ride.user.id), flash: { message: message }
    end

    private

    def ride_params
        params.require(:ride).permit(:attraction_id, :user_id)
    end

end
