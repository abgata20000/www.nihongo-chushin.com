# frozen_string_literal: true

create_table :active_storage_attachments, comment: 'active_storageのファイル管理用' do |t|
  t.string :name, null: false
  t.references :record, null: false, polymorphic: true, index: false
  t.references :blob, null: false

  t.datetime :created_at, null: false

  t.index %i[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
end
