require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  render_views

  subject { get method }
  let(:method) { :top }

  before do
    subject
  end

  describe "#top" do
    context "正常系" do
      it "レスポンスステータスが200であること" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#vue_sample" do
    let(:method) { :vue_sample }
    context "正常系" do
      it "レスポンスステータスが200であること" do
        expect(response).to have_http_status(200)
      end
    end
  end
end
