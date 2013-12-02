class FixCreateComments < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
  		t.rename :com, :body
  	end
  end
end
