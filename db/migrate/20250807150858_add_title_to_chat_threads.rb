class AddTitleToChatThreads < ActiveRecord::Migration[7.1]
  def change
    add_column :chat_threads, :title, :string, null: false, default: "Untitled"
  end
end
