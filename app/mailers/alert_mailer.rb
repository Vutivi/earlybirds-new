class AlertMailer < ApplicationMailer
    def new_trip_message(user, message, trip)
        @user    = user
        @trip    = trip
        @message = message
        subject  = "#{message.user.full_name} sent a message on your #{trip.kind.humanize} trip."

        mail(to: @user.email, subject: subject)
    end
end
