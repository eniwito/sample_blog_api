class CreateIps < ActiveRecord::Migration[5.2]
  def change
    create_table :ips do |t|
      t.inet :ip

      t.timestamps
    end
  end
end
