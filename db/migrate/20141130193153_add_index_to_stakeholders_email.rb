class AddIndexToStakeholdersEmail < ActiveRecord::Migration
  def change
  	add_index :stakeholders, :email, unique: true
  end
end
