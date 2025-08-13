class CreateSymptoms < ActiveRecord::Migration[7.1]
  def change
    create_table :symptoms do |t|
      t.string :title
      t.text :summary
      t.text :home_care
      t.text :checkpoints
      t.text :visit_immediate
      t.text :visit_hours

      t.timestamps
    end
  end
end
