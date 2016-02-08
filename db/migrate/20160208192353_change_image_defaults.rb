class ChangeImageDefaults < ActiveRecord::Migration
  def change
    change_column :images, :sharpness,  :integer, default: 0
    change_column :images, :contrast,   :integer, default: 0
    change_column :images, :brightness, :integer, default: 50
    change_column :images, :saturation, :integer, default: 0
  end
end
