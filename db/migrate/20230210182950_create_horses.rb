class CreateHorses < ActiveRecord::Migration[7.0]
  def change
    create_table :horses do |t|
      t.string :name
      t.string :brand
      t.string :herd
      t.string :difficulty
      t.string :condition
      
      t.timestamps
    end
  end
end
