require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  render_views
  describe "#top" do
    subject { get method }
    let(:method) { :top }

    context "固定部屋にコメントがない場合" do
      before do
        subject
      end
      it "部屋一覧にリダイレクトされること" do
        expect(response).to redirect_to rooms_path
      end
    end

    context "固定部屋にコメントがある場合" do
      let(:user) { create(:user) }
      let(:room) { create(:room, user: user, is_fixed: true, is_public: true) }
      let(:chats) do
        tmp = []
        user.update!(room: room)
        10.times do |_i|
          tmp << create(:chat, user: user)
        end
        tmp
      end
      let(:chat) { chats.first }
      before do
        chat
        subject
      end
      it "レスポンスステータスが200であること" do
        expect(response).to have_http_status(200)
      end

      it "固定部屋のデータが表示されること" do
        expect(assigns(:room).id).to eq(room.id)
        expect(assigns(:chats)).to include(chat)
      end
    end
  end

  describe "#vue_sample" do
    subject { get method }
    let(:method) { :vue_sample }

    before do
      subject
    end

    context "正常系" do
      it "レスポンスステータスが200であること" do
        expect(response).to have_http_status(200)
      end
    end
  end
end
