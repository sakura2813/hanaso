class ChatThread < ApplicationRecord
  belongs_to :user
  has_many   :messages, dependent: :destroy
  # 会話全体を文字列化するヘルパー
  def conversation_text
    messages.order(:created_at).pluck(:prompt, :response).flatten.join("\n")
  end
end
