class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.integer :sharpness
      t.integer :contrast
      t.integer :brightness
      t.integer :saturation
      t.integer :iso
      t.integer :speed

      t.timestamps null: false
    end
  end
end
