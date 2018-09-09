create_table :premium_users, comment: 'プレミアムユーザー情報' do |t|
  t.integer :user_id, null: true, comment: 'ユーザーID'
  t.string :username, null: true, comment: 'ユーザー名'
  t.string :email, null: true, comment: 'メールアドレス'
  t.string :password_digest, comment: 'パスワード(暗号化)'
  t.text :memo, null: true, comment: 'メモ'
  t.string :ip, null: true, comment: 'IP'
  t.text :user_agent, null: true, comment: 'UA情報'
  t.timestamps
  #
  t.index :user_id, unique: true
  t.index :username, unique: true
  t.index :email, unique: true
end
