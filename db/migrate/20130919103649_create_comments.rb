class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :user_id
    	t.integer :post_id
    	t.string :com
    	t.timestamp
    end
  end
end
