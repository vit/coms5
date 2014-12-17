json.array!(@journal_journals) do |journal_journal|
  json.extract! journal_journal, :id, :title, :description, :slug, :user_id
  json.url journal_journal_url(journal_journal, format: :json)
end
