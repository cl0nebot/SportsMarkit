class AddFieldsToMedias < ActiveRecord::Migration
  def change
    add_column :media, :title, :string
    add_column :media, :url, :string
    add_column :media, :publish_date, :date
  end
end
