class ChangeFirstNameAndAgeInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :first_name, true
    change_column_null :users, :age, true
  end
end
