class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :title
      t.text :description
      t.attachment :avatar

      t.timestamps
    end
  end
end
