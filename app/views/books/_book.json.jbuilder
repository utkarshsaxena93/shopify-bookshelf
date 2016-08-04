json.extract! book, :id, :isbn, :googleid, :category, :created_at, :updated_at
json.url book_url(book, format: :json)