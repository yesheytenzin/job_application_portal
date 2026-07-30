class CreateJobApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :job_applications do |t|
      t.string :status, null: false, default: 'submitted'

      t.timestamps
    end
  end
end
