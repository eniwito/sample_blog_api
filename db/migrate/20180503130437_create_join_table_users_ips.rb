class CreateJoinTableUsersIps < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :ips do |t|
      t.index [:user_id, :ip_id]
      t.index [:ip_id, :user_id]
    end
  end
end
