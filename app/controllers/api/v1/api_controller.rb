module Api::V1
  class ApiController < ApplicationController
    def current_user
      User.find(doorkeeper_token.resource_owner_id)
    end
  end
end
