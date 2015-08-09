ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.date :date_of_birth
    t.timestamps
  end

end