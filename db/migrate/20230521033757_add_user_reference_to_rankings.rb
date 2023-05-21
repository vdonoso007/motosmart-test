class AddUserReferenceToRankings < ActiveRecord::Migration[7.0]
  def change
    add_reference :rankings, :user, null: false, foreign_key: true
  end
end
