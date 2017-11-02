class CreateChanns < ActiveRecord::Migration[5.0]
  def change
    create_table :channs do |t|
      t.integer :user_id
      t.string :name
      t.integer :feed_id
      t.boolean :email_notification
      t.integer :email_period
      t.boolean :tgram_notification
      t.integer :tgram_period

      t.timestamps
    end
  end
end
