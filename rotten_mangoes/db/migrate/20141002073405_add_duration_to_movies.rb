class AddDurationToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :duration, :string
  end
end
