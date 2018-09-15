require "features/spec_helper"

feature "トップページの表示", type: :feature, js: true do
  before do
    visit(root_path)
  end

  scenario "固定部屋の会話がない場合はトップページから部屋一覧へ飛ぶ" do
    expect(current_path).to eq(rooms_path)
  end
end
