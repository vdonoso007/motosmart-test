class CreateRankings < ActiveRecord::Migration[7.0]
  def change
    create_table :rankings do |t|
      t.integer :kilometers
      t.datetime :startDate
      t.datetime :endDate

      t.timestamps
    end
  end
end
