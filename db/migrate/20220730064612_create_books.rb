class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      
      t.string:title      ,null:false
      t.string:auther     ,null:false
      t.string:image_url

      t.timestamps
    end
  end
end
