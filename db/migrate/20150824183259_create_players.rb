class CreatePlayers < ActiveRecord::Migration
  def change
    create_table(:players) do |t|
      t.column(:name, :string)
      t.column(:team_captain, :boolean)
      t.column(:team_id, :integer)

      t.timestamps()
    end
  end
end
