class CreateUsages < ActiveRecord::Migration[8.1]
  def change
    create_table :usages do |t|
      t.references :api_key, null: false, foreign_key: true
      t.string :endpoint
      t.integer :request_count

      t.timestamps
    end
  end
end
