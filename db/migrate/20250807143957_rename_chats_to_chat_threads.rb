class RenameChatsToChatThreads < ActiveRecord::Migration[6.1]
  def change
    # テーブル名を chats → chat_threads に変更
    rename_table :chats, :chat_threads
    # カラム名とインデックスも一緒にリネーム
    rename_column :messages, :chat_id, :chat_thread_id
  end
end

