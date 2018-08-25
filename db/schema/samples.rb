# frozen_string_literal: true

create_table :samples, comment: 'サンプル' do |t|
  t.string :name
  t.text :memo
  t.timestamps
end
