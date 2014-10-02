class RemoveDurationFromMovies < ActiveRecord::Migration
  def change
  	remove_column :movies, :duration
  end
end
