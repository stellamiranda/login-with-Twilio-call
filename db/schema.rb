ActiveRecord::Schema.define(version: 20150301024906) do
  
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "celphone"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "code",          limit: 8
  end

end
