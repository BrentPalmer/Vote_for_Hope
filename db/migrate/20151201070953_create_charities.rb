class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string :name
      t.string :description
      t.string :mission_statement
      t.string :avatar
      t.string :background_image
      t.string :url
      t.timestamps
    end
  end
end
