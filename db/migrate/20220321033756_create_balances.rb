class CreateBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :balances do |t|
      t.references :user, null: false, foreign_key: true
      t.float :balance_value, null: false, default: 0.0

      t.timestamps
    end
  end
end
