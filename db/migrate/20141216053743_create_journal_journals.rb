class CreateJournalJournals < ActiveRecord::Migration
  def change
    create_table :journal_journals do |t|
      t.string :title
      t.text :description
      t.string :slug
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :journal_journals, :slug, unique: true
    add_foreign_key :journal_journals, :users
  end
end
