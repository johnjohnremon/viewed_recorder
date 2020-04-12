class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :title
      t.datetime :datetime
      t.text :site
      t.text :comment
      t.integer :assess

      t.timestamps
    end
  end
end
