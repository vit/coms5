class CreateJournalAppointment < ActiveRecord::Migration
  def change
    create_table :journal_appointments do |t|
      t.references :journal, index: true
      t.references :user, index: true
      t.string :role_name
    end
    add_index :journal_appointments, [:journal_id, :user_id, :role_name], name: 'index_journal_appointments_journal_user_role', unique: true
    add_foreign_key :journal_appointments, :journal_journals
    add_foreign_key :journal_appointments, :users
  end
end
