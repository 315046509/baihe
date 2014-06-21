class CreateJournalisms < ActiveRecord::Migration
  def change
    create_table :journalisms do |t|
      t.string :title
      t.text :descrpiton
      t.integer :question_category_id, :default => 0

      t.timestamps
    end
  end
end
