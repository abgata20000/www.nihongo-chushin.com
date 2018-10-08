create_table :tasks, comment: "タスク管理" do |t|
  t.string :key, null: false, comment: "キー"
  t.string :name, null: true, comment: "名前"
  t.integer :total_exec_count, null: false, default: 0, comment: "累計実行回数"
  t.integer :exec_count, null: false, default: 0, comment: "実行回数"
  t.integer :max_exec_count, null: false, default: 0, comment: "最大実行回数(リセットに利用)"
  t.boolean :is_running, null: false, default: false, comment: "実行中の判定"
  t.text :comment, null: true, comment: "コメント内容"
  t.timestamps

  t.index :key, unique: true
end
