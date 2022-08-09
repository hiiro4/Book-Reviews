class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer:user_id   ,null:false
      t.string:book_id    ,null:false
      t.string:title
      t.string:book_title
      t.text:body
      t.float:assess

      t.timestamps
    end
  end
end
