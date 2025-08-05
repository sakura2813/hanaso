class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :symptom, null: true
      t.string :category, null: false

      t.timestamps
    end
  end
end
