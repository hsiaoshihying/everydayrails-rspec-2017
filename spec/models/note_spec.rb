require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }

  before do
    allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
    allow(Project).to receive(:find).with("123").and_return(project)
  end

  describe "#index" do
  # 入力されたキーワードでメモを検索すること
    it "searches notes by the provided keyword" do
      expect(project).to receive_message_chain(:notes, :search).with("rotate tires")
      get :index,
          params: { project_id: project.id, term: "rotate tires" }
    end
  end
end
