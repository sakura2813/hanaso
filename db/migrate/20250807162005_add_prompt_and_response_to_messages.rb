class AddPromptAndResponseToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :prompt, :text
    add_column :messages, :response, :text
  end
end
