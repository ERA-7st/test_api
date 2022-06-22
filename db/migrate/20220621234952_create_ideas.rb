class CreateIdeas < ActiveRecord::Migration[7.0]
  def change
    create_table :ideas, id: false do |t|
      t.column :id, "BIGINT PRIMARY KEY AUTO_INCREMENT"
      t.bigint :category_id, null: false
      t.string :bigint, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
