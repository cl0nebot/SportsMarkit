class AddFileToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :file, :string
  end
end
