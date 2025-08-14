class ChatThreadsController < ApplicationController
  before_action :authenticate_user!
  def index
    latest = Message
               .select('chat_thread_id, MAX(created_at) AS last_message_at')
               .group(:chat_thread_id)
  
    @chat_threads = ChatThread
                      .joins("INNER JOIN (#{latest.to_sql}) latest ON latest.chat_thread_id = chat_threads.id")
                      .order('latest.last_message_at DESC')
  
    respond_to do |format|
      format.json { render json: { chat_threads: @chat_threads } }
      format.html
    end
  end

  def create
    @chat_thread = current_user.chat_threads.build(title: 'Untitled')

    if @chat_thread.save
      render json: { chat_thread: @chat_thread }, status: :created
    else
      render json: { errors: @chat_thread.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @chat_thread = ChatThread.find(params[:id])
    @message = @chat_thread.messages.build

    respond_to do |format|
      format.json do
        render json: {
          chat_thread: @chat_thread.as_json(only: [:id, :title, :context]),
          messages: @chat_thread.messages.order(:created_at).as_json(
            only: [:id, :prompt, :response, :created_at]
          )
        }
      end
      format.html { render :index }
    end
  end
end
