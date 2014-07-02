class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversations, except: :update
  before_action :set_conversation, :set_participant, only: [:show, :edit, :update]

  def index
  end

  def show
    @receipts = @conversation.receipts_for(@participant).reverse
    @participants = { @participant.id => @participant, current_user.id => current_user }
    @title = "Conversation avec #{@participant.name}"
  end

  def new
    participant_id = params[:user_id].to_i
    conversations = Mailboxer::Conversation.participant(current_user).where(
                      'mailboxer_conversations.id in (?)',
                      Mailboxer::Conversation.participant(User.find(participant_id)).collect(&:id)
                    )
    return redirect_to edit_message_path(conversations.first) if conversations.any?
    @participant = User.find(participant_id)
    @title = "Commencer une conversation avec #{@participant.name}"
  end

  def create
    @message = current_user.send_message(
      User.find(params[:participant][:id].to_i),
      params[:conversation][:body],
      params[:conversation][:subject]
    )
    redirect_to message_path(@message.conversation)
  end

  def edit
    @title = "Répondre à #{@participant.name}"
  end

  def update
    permitted_params = params[:conversation].permit(:id, :body)
    @conversation = current_user.mailbox.conversations.find(params[:conversation][:id].to_i)
    current_user.reply_to_conversation(@conversation, params[:conversation][:body])
    redirect_to message_path(@conversation)
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

    def set_participant
      @participant = @conversation.participants.reject { |p| p == current_user }.first
    end
end
