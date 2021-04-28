json.extract! book, :id, :name, :description, :image_url, :price, :isbn, :created_at, :updated_at
json.url book_url(book, format: :json)
