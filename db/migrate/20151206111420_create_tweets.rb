class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :content, null: false

      t.timestamps null: false
    end
  end
end
