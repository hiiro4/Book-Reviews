class CreateBookshelves < ActiveRecord::Migration[6.1]
  def change
    create_table :bookshelves do |t|
      
      t.integer:read_id         
      t.integer:will_read_id  

      t.timestamps
    end
  end
end
