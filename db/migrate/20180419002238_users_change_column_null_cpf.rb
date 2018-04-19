class UsersChangeColumnNullCpf < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :cpf, true
  end
end
