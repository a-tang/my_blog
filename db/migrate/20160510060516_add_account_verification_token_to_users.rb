class AddAccountVerificationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_verification_token, :string
  end
end
