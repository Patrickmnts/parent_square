class CreateMessage < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :status
      t.string :message_id
      t.string :content
      t.string :to_number
      t.timestamps
    end

    add_index :messages, :message_id
    add_index :messages, :status
  end
end
