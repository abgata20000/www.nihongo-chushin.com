# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", comment: "active_storageのファイル管理用", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", comment: "active_storageのID管理用", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "chats", comment: "チャット", force: :cascade do |t|
    t.integer "user_id", comment: "ユーザーID"
    t.integer "room_id", null: false, comment: "部屋ID"
    t.string "nickname", comment: "コメントした時のニックネーム"
    t.string "color", comment: "コメント時の色"
    t.string "icon", comment: "コメント時のアイコン"
    t.text "comment", comment: "コメント内容"
    t.boolean "system_message", default: true, null: false, comment: "システムメッセージかどうかの判定"
    t.datetime "deleted_at", comment: "削除時間"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_chats_on_created_at"
    t.index ["deleted_at"], name: "index_chats_on_deleted_at"
    t.index ["room_id"], name: "index_chats_on_room_id"
    t.index ["updated_at"], name: "index_chats_on_updated_at"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "premium_users", comment: "プレミアムユーザー情報", force: :cascade do |t|
    t.integer "user_id", comment: "ユーザーID"
    t.string "username", comment: "ユーザー名"
    t.string "email", comment: "メールアドレス"
    t.string "password_digest", comment: "パスワード(暗号化)"
    t.text "memo", comment: "メモ"
    t.string "ip", comment: "IP"
    t.text "user_agent", comment: "UA情報"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_premium_users_on_email", unique: true
    t.index ["user_id"], name: "index_premium_users_on_user_id", unique: true
    t.index ["username"], name: "index_premium_users_on_username", unique: true
  end

  create_table "rooms", comment: "部屋情報", force: :cascade do |t|
    t.integer "user_id", null: false, comment: "オーナーユーザーID"
    t.string "name", null: false, comment: "部屋名"
    t.string "password", comment: "パスワード"
    t.string "language", default: "ja", null: false, comment: "言語"
    t.boolean "can_knock", default: false, null: false, comment: "ノック可能かどうか"
    t.boolean "is_public", default: false, null: false, comment: "公開部屋フラグ"
    t.boolean "is_visible", default: true, null: false, comment: "表示・非表示"
    t.boolean "is_fixed", default: false, null: false, comment: "固定部屋"
    t.integer "connection_disconnected_time", default: 60, null: false, comment: "接続切れからの強制退出までの時間"
    t.integer "comment_disconnected_time", default: 600, null: false, comment: "最終コメントから強制退出までの時間"
    t.integer "num", default: 5, null: false, comment: "人数"
    t.integer "show_comment_count", default: 100, null: false, comment: "表示するコメント数"
    t.text "memo", comment: "メモ"
    t.datetime "deleted_at", comment: "削除時間"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_rooms_on_created_at"
    t.index ["deleted_at"], name: "index_rooms_on_deleted_at"
    t.index ["language"], name: "index_rooms_on_language"
    t.index ["updated_at"], name: "index_rooms_on_updated_at"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "task_locks", comment: "タスク管理", force: :cascade do |t|
    t.string "key", null: false, comment: "管理用のキー(ユニーク)"
    t.string "name", comment: "タスク名"
    t.integer "exec_block_count", default: 0, comment: "ロック中に叩かれてブロックされた回数"
    t.integer "exec_count", default: 0, comment: "累計実行回数"
    t.integer "block_limit_count", default: 0, comment: "何回ブロックされたらロックを解除するかの回数"
    t.datetime "last_executed_at", comment: "最終実行日時"
    t.boolean "locking", default: false, comment: "ロック中の判定"
    t.text "memo", comment: "メモ"
    t.integer "once_exec_limit", comment: "1回の実行で処理する件数"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_task_locks_on_key", unique: true
  end

  create_table "users", comment: "ユーザー情報", force: :cascade do |t|
    t.integer "room_id", comment: "部屋ID"
    t.string "name", comment: "ユーザー名"
    t.string "nickname", comment: "ユーザー名(ニックネーム)"
    t.string "token", comment: "トークン"
    t.integer "role", default: 1, null: false, comment: "権限"
    t.string "color", comment: "色"
    t.string "icon", comment: "アイコン"
    t.string "sound", comment: "効果音"
    t.string "language", default: "ja", null: false, comment: "言語"
    t.boolean "is_connected", default: false, comment: "接続判定"
    t.boolean "is_mobile", default: false, comment: "Mobile"
    t.boolean "enabled", default: true, null: false, comment: "有効・無効"
    t.datetime "into_the_room_at"
    t.datetime "last_commented_at"
    t.datetime "last_connected_at"
    t.datetime "last_logged_in_at", comment: "最終ログイン時間"
    t.text "memo", comment: "メモ"
    t.string "ip", comment: "IP"
    t.text "user_agent", comment: "UA情報"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["into_the_room_at"], name: "index_users_on_into_the_room_at"
    t.index ["language"], name: "index_users_on_language"
    t.index ["last_commented_at"], name: "index_users_on_last_commented_at"
    t.index ["last_connected_at"], name: "index_users_on_last_connected_at"
    t.index ["last_logged_in_at"], name: "index_users_on_last_logged_in_at"
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["room_id"], name: "index_users_on_room_id"
    t.index ["token"], name: "index_users_on_token", unique: true
    t.index ["updated_at"], name: "index_users_on_updated_at"
  end

end
