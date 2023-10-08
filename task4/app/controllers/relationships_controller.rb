class RelationshipsController < ApplicationController
    def create
        relationship = Relationship.new()
        relationship.follower_id = current_user.id
        relationship.followee_id = params[:user_id]
        relationship.save()
        redirect_to request.referer
    end

    def destory
        relationship = Relationship.find_by(follower_id: current_user.id.to_i(), followee_id: params[:user_id].to_i())
        relationship.destory()
        redirect_to request.referer
    end
end
