class CreateJournalisms < ActiveRecord::Migration
  def change
    create_table :journalisms do |t|
      t.string :title
      t.text :descrpiton
      t.attachment :avatar

      t.timestamps
    end
  end
end
