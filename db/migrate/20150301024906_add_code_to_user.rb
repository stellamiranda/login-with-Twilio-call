class AddCodeToUser < ActiveRecord::Migration
  	def change
  		add_column :users, :code, :integer, limit: 6
  	end
end
