class ChangeCategoryNullOnChatThreads < ActiveRecord::Migration[7.1]
  def change
    change_column_null :chat_threads, :category, true
  end
end
