class CreateTeams < ActiveRecord::Migration
  def change
    create_table(:teams) do |t|
      t.column(:name, :string)
      t.column(:win, :integer)
      t.column(:loss, :integer)

      t.timestamps()
    end
  end
end
