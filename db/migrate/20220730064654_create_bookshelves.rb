class CreateBookshelves < ActiveRecord::Migration[6.1]
  def change
    create_table :bookshelves do |t|

      t.string  :read_id
      t.string  :will_read_id
      t.string  :book_title
      t.integer :user_id

      t.timestamps
    end
  end
end
