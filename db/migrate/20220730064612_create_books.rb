class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|

      t.string  :review_type    #レビュー検索用
      t.string  :review_range   #レビュー検索用
      t.string  :book_category  #本検索切り替え
      t.string  :book_id        ,null:false

      t.timestamps
    end
  end
end
