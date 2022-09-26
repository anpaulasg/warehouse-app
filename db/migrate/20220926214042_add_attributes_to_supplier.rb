class AddAttributesToSupplier < ActiveRecord::Migration[7.0]
  def change
    add_column :suppliers, :telephone, :string
  end
end
