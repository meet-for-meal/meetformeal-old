class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversations

  def index
  end

  def show
    set_conversation
    @participant = @conversation.participants.reject { |p| p == current_user }.first
    @receipts = @conversation.receipts_for(@participant).reverse
    @participants = { @participant.id => @participant, current_user.id => current_user }
    @title = "Conversation avec #{@participant.name}"
  end

  private

    def set_conversations
      @conversations = current_user.mailbox.conversations
    end

    def set_conversation
      begin
       @conversation = current_user.mailbox.conversations.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "This conversation can't be found."
        redirect_to homepage_path
      end
    end
end
