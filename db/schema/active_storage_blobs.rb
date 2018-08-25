# frozen_string_literal: true

create_table :active_storage_blobs, comment: 'active_storageのID管理用' do |t|
  t.string :key, null: false
  t.string :filename, null: false
  t.string :content_type
  t.text :metadata
  t.bigint :byte_size, null: false
  t.string :checksum, null: false
  t.datetime :created_at, null: false

  t.index [:key], unique: true
end
