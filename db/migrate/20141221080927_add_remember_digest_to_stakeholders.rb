class AddRememberDigestToStakeholders < ActiveRecord::Migration
  def change
    add_column :stakeholders, :remember_digest, :string
  end
end
