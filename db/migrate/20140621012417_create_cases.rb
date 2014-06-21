class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :title
      t.text :description
      t.attachment :avatar
      t.integer :question_category_id, :default => 0

      t.timestamps
    end
  end
end
