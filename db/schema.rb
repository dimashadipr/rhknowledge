# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_19_082710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_messages", force: :cascade do |t|
    t.string "user_type"
    t.bigint "user_id"
    t.text "to"
    t.string "mailer"
    t.text "subject"
    t.datetime "sent_at"
    t.string "token"
    t.datetime "opened_at"
    t.datetime "clicked_at"
    t.index ["token"], name: "index_ahoy_messages_on_token"
    t.index ["user_type", "user_id"], name: "index_ahoy_messages_on_user_type_and_user_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "conference_assets", force: :cascade do |t|
    t.bigint "conference_id"
    t.string "type"
    t.string "image"
    t.string "file"
    t.string "label"
    t.integer "position"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conference_id"], name: "index_conference_assets_on_conference_id"
  end

  create_table "conference_file_reviews", force: :cascade do |t|
    t.bigint "conference_id"
    t.string "category"
    t.string "code"
    t.string "description"
    t.string "option"
    t.jsonb "data", default: {}
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conference_id"], name: "index_conference_file_reviews_on_conference_id"
  end

  create_table "conference_letters", force: :cascade do |t|
    t.bigint "conference_id"
    t.string "name"
    t.string "title"
    t.string "message"
    t.string "image"
    t.integer "position"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conference_id"], name: "index_conference_letters_on_conference_id"
  end

  create_table "conference_participants", force: :cascade do |t|
    t.bigint "conference_id"
    t.string "category"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "abstract_needed", default: false
    t.jsonb "data", default: {}
    t.index ["conference_id"], name: "index_conference_participants_on_conference_id"
  end

  create_table "conference_registrations", force: :cascade do |t|
    t.bigint "conference_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conference_id"], name: "index_conference_registrations_on_conference_id"
  end

  create_table "conference_speakers", force: :cascade do |t|
    t.bigint "conference_id"
    t.string "name"
    t.string "title"
    t.string "image"
    t.integer "position"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "group"
    t.string "conference_position"
    t.index ["conference_id"], name: "index_conference_speakers_on_conference_id"
  end

  create_table "conference_topic_reviewers", force: :cascade do |t|
    t.bigint "conference_topic_id"
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conference_topic_id"], name: "index_conference_topic_reviewers_on_conference_topic_id"
    t.index ["user_id"], name: "index_conference_topic_reviewers_on_user_id"
  end

  create_table "conference_topics", force: :cascade do |t|
    t.bigint "conference_id"
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conference_id"], name: "index_conference_topics_on_conference_id"
  end

  create_table "conferences", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "description"
    t.string "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "image_articles", force: :cascade do |t|
    t.string "file"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "message"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mailer_files", force: :cascade do |t|
    t.bigint "mailer_id"
    t.string "file"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mailer_id"], name: "index_mailer_files_on_mailer_id"
  end

  create_table "mailer_recipients", force: :cascade do |t|
    t.bigint "mailer_id"
    t.string "email"
    t.string "name"
    t.string "status"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "data", default: {}
    t.index ["mailer_id"], name: "index_mailer_recipients_on_mailer_id"
  end

  create_table "mailers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "status"
    t.string "subject"
    t.string "slug"
    t.text "content"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_mailers_on_user_id"
  end

  create_table "navigations", force: :cascade do |t|
    t.integer "navigation_id"
    t.string "code"
    t.integer "position"
    t.string "title"
    t.bigint "page_id"
    t.integer "level"
    t.boolean "editable", default: true
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tooltip"
    t.index ["page_id"], name: "index_navigations_on_page_id"
  end

  create_table "networks", force: :cascade do |t|
    t.string "logo"
    t.string "name"
    t.string "description"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
  end

  create_table "page_banner_details", force: :cascade do |t|
    t.bigint "page_component_id"
    t.string "image"
    t.string "label"
    t.string "sublabel"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.index ["page_component_id"], name: "index_page_banner_details_on_page_component_id"
  end

  create_table "page_components", force: :cascade do |t|
    t.bigint "page_id"
    t.string "type"
    t.integer "position"
    t.string "reference_type"
    t.integer "reference_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_id"], name: "index_page_components_on_page_id"
  end

  create_table "page_link_details", force: :cascade do |t|
    t.bigint "page_component_id"
    t.bigint "page_id"
    t.string "image"
    t.string "title"
    t.string "description"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_component_id"], name: "index_page_link_details_on_page_component_id"
    t.index ["page_id"], name: "index_page_link_details_on_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "parent_id"
    t.string "type"
    t.string "title"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.jsonb "data", default: {}
    t.string "description"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
    t.index ["user_id"], name: "index_pages_on_user_id"
  end

  create_table "participant_file_reviews", force: :cascade do |t|
    t.bigint "participant_file_id"
    t.bigint "user_id"
    t.string "status"
    t.string "note"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "created_by"
    t.integer "score"
    t.index ["participant_file_id"], name: "index_participant_file_reviews_on_participant_file_id"
    t.index ["user_id"], name: "index_participant_file_reviews_on_user_id"
  end

  create_table "participant_files", force: :cascade do |t|
    t.bigint "participant_id"
    t.string "type"
    t.string "file"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.jsonb "data", default: {}
    t.index ["participant_id"], name: "index_participant_files_on_participant_id"
  end

  create_table "participant_logs", force: :cascade do |t|
    t.bigint "participant_id"
    t.string "message"
    t.jsonb "params"
    t.jsonb "data"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "resource_type"
    t.integer "resource_id"
    t.bigint "user_id"
    t.integer "public", default: 0
    t.index ["participant_id"], name: "index_participant_logs_on_participant_id"
    t.index ["user_id"], name: "index_participant_logs_on_user_id"
  end

  create_table "participant_review_scores", force: :cascade do |t|
    t.bigint "participant_file_reviews_id"
    t.string "category"
    t.integer "score"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "conference_file_review_id"
    t.index ["conference_file_review_id"], name: "index_participant_review_scores_on_conference_file_review_id"
    t.index ["participant_file_reviews_id"], name: "index_participant_review_scores_on_participant_file_reviews_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id"
    t.string "front_title"
    t.string "back_title"
    t.string "title"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "institution"
    t.string "institution_phone"
    t.string "participant"
    t.string "topic"
    t.string "abstract"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "whatsapp"
    t.jsonb "data", default: {}
    t.string "slug"
    t.bigint "conference_id"
    t.bigint "conference_participant_id"
    t.bigint "conference_topic_id"
    t.index ["conference_id"], name: "index_participants_on_conference_id"
    t.index ["conference_participant_id"], name: "index_participants_on_conference_participant_id"
    t.index ["conference_topic_id"], name: "index_participants_on_conference_topic_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.string "action"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recurring_events", force: :cascade do |t|
    t.bigint "user_id"
    t.string "category", comment: "daily, weekly, monthly, yearly"
    t.string "name"
    t.integer "day_number", comment: "for weekly 0-6, 0: sunday "
    t.integer "day_date", comment: "for monthly, select day date"
    t.integer "month_number", comment: "for yearly, select month date number"
    t.datetime "active_until"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_recurring_events_on_user_id"
  end

  create_table "resource_details", force: :cascade do |t|
    t.bigint "page_component_id"
    t.bigint "source_id"
    t.string "image"
    t.text "content"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "navigation_id"
    t.index ["navigation_id"], name: "index_resource_details_on_navigation_id"
    t.index ["page_component_id"], name: "index_resource_details_on_page_component_id"
    t.index ["source_id"], name: "index_resource_details_on_source_id"
  end

  create_table "resource_files", force: :cascade do |t|
    t.bigint "page_component_id"
    t.string "file"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_component_id"], name: "index_resource_files_on_page_component_id"
  end

  create_table "role_abilities", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "permission_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["permission_id"], name: "index_role_abilities_on_permission_id"
    t.index ["role_id"], name: "index_role_abilities_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "type"
    t.string "code"
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type"], name: "index_roles_on_type"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "image_header"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "institution"
    t.boolean "active", default: true
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "translations", force: :cascade do |t|
    t.string "lang"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "column"
    t.text "content"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "type"
    t.bigint "role_id"
    t.string "name"
    t.string "phone"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.jsonb "data", default: {}
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["type"], name: "index_users_on_type"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "conference_file_reviews", "conferences"
  add_foreign_key "conference_topic_reviewers", "users"
  add_foreign_key "events", "users"
  add_foreign_key "mailer_files", "mailers"
  add_foreign_key "mailer_recipients", "mailers"
  add_foreign_key "mailers", "users"
  add_foreign_key "navigations", "pages"
  add_foreign_key "page_components", "pages"
  add_foreign_key "page_link_details", "page_components"
  add_foreign_key "page_link_details", "pages"
  add_foreign_key "participant_file_reviews", "participant_files"
  add_foreign_key "participant_file_reviews", "users"
  add_foreign_key "participant_files", "participants"
  add_foreign_key "participant_logs", "participants"
  add_foreign_key "participant_logs", "users"
  add_foreign_key "participant_review_scores", "conference_file_reviews"
  add_foreign_key "participant_review_scores", "participant_file_reviews", column: "participant_file_reviews_id"
  add_foreign_key "participants", "conference_participants"
  add_foreign_key "participants", "conference_topics"
  add_foreign_key "participants", "conferences"
  add_foreign_key "recurring_events", "users"
  add_foreign_key "resource_details", "navigations"
  add_foreign_key "resource_details", "page_components"
  add_foreign_key "resource_details", "sources"
  add_foreign_key "resource_files", "page_components"
  add_foreign_key "role_abilities", "permissions"
  add_foreign_key "role_abilities", "roles"
  add_foreign_key "taggings", "tags"
  add_foreign_key "users", "roles"
end
