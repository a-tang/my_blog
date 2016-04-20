class RemoveTitleFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :title, :string
  end
end
