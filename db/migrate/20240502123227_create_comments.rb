class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :post, null: false, foreign_key: true
      t.references :user, column: :author_id, null: false, foreign_key: true
      t.string :context

      t.timestamps
    end
  end
end
