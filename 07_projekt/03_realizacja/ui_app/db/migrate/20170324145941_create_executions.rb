class CreateExecutions < ActiveRecord::Migration[5.0]
  def change
    create_table :executions do |t|
      t.string :action
      t.text :params
      t.string :user_agent
      t.text :referer
      t.text :query
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
