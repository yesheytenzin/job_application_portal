class AddUniqueIndexToJobApplications < ActiveRecord::Migration[8.1]
  def change
    add_index :job_applications,
    [ :user_id, :job_id ],
    unique: true,
    name: 'index_job_applications'
  end
end
