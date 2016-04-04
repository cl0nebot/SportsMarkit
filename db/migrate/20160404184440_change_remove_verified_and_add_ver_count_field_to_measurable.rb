class ChangeRemoveVerifiedAndAddVerCountFieldToMeasurable < ActiveRecord::Migration
  def change
    remove_column :measurables, :verified
    add_column :measurables, :verifications_count, :integer, null: false, default: 0
  end
end
