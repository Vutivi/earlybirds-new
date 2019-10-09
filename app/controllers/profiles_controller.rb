class ProfilesController < ApplicationController
    def index
    end

    def settings
        @resource ||= current_user
    end
end