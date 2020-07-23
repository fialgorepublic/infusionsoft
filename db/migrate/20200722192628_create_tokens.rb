class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :access_token
      t.string :refresh_token

      t.timestamps
    end
  end
end
