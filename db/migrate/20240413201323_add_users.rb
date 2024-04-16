class AddUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.integer :age, null: false
      t.string :last_name

      t.timestamps
    end
  end
end
