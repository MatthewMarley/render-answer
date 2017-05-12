class FriendshipsController < ApplicationController
  
  def destroy
    @friendships = current_user.friendships.where(friend_id: params[:id]).first
    @friendships.destroy
    respond_to do |format|
      format.html { redirect_to friends_path, notice: "Friend was successfully removed" }
    end
  end
  
end