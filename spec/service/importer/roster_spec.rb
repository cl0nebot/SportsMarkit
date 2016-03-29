require 'rails_helper'

RSpec.describe Importer::Roster do
  let(:team){ create :team }
  let(:run_import){ Importer::Roster.call(file: file, team_id: team.id) }

  context "valid roster" do
    context "user role roster" do
      let(:file){ uploaded_file("import/valid_user_role_roster.xlsx") }

      it "should create 1 user" do
        expect{ run_import }.to change{ User.count }.by(1)
      end

      it "should create 1 role" do
        expect{ run_import }.to change{ team.roles.count }.by(1)
      end
    end

    context "userless role roster" do
      let(:file){ uploaded_file("import/valid_userless_role_roster.xlsx") }

      it "should create 0 user" do
        expect{ run_import }.to change{ User.count }.by(0)
      end

      it "should create 0 role" do
        expect{ run_import }.to change{ team.roles.count }.by(0)
      end

      it "should create 1 userless role" do
        expect{ run_import }.to change{ team.userless_roles.count }.by(1)
      end
    end
  end

  context "invalid roster" do
    context "user role roster" do
      let(:file){ uploaded_file("import/invalid_roster.xlsx") }

      it 'should create 0 user' do
        expect{ run_import }.to change{User.count}.by(0)
      end

      it 'should create 0 role' do
        expect{ run_import }.to change{team.roles.count}.by(0)
      end

      it 'should create 0 userless role' do
        expect{ run_import }.to change{team.userless_roles.count}.by(0)
      end
    end
  end
end