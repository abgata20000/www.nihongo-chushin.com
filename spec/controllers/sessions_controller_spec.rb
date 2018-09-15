require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  render_views
  describe "#new" do
    subject { get method }
    let(:method) { :new }

    before do
      subject
    end

    context "正常系" do
      it "レスポンスステータスが200であること" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#create" do
    subject { post method, params: params }
    let(:method) { :create }
    let(:params) do
      {
        user_session: {
          nickname: nickname,
          icon: icon
        }
      }
    end
    let(:nickname) { "ああああ" }
    let(:icon) { "icon_2" }
    let(:user) { create(:user) }

    before do
      visit_user(user)
    end

    context "正常系" do
      it "部屋一覧にリダイレクトされること" do
        subject
        expect(response).to redirect_to rooms_path
      end

      it "ユーザー名が設定されること" do
        expect { subject }.to change { user.reload.nickname }.from(nil).to(nickname)
      end
    end
  end

  describe "#destroy" do
    subject { delete method }
    let(:method) { :destroy }
    let(:nickname) { "ああああ" }
    let(:user) { create(:user, nickname: nickname) }

    before do
      visit_user(user)
    end

    context "正常系" do
      it "TOP画面にリダイレクトされること" do
        subject
        expect(response).to redirect_to root_path
      end

      it "ユーザー名がリセットされること" do
        expect { subject }.to change { user.reload.nickname }.from(nickname).to(nil)
      end
    end
  end
end
