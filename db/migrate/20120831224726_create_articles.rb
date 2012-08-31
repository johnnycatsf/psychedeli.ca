class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :category
      t.date :date
      t.string :tags
      t.boolean :published
      t.text :source
      t.text :content

      t.timestamps
    end
  end
end
