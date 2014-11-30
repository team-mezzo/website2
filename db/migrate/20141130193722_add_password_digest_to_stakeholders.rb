class AddPasswordDigestToStakeholders < ActiveRecord::Migration
  def change
    add_column :stakeholders, :password_digest, :string
  end
end
