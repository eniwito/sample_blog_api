class CreateIps < ActiveRecord::Migration[5.2]
  def change
    create_table :ips do |t|
      t.inet :ip
      t.string :login

      t.timestamps
    end
  end
end
