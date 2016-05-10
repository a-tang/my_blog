class AddAccountVerificationRequestedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_verification_requested_at, :datetime
  end
end
