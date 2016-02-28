require 'rails_helper'

RSpec.describe Importer::Team do
  let(:school){ create :school }
  let(:run_import){ School.import_team(file, school.id) }

  def uploaded_file(path)
    file = File.new(Rails.root.join('spec/fixtures/files', path))
    file.rewind
    ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
  end

  context 'valid file' do
    let(:file){ uploaded_file('import/valid_teams_with_user_role.xlsx') }

    it 'should create 1 team' do
      expect{ run_import }.to change{Team.count}.by(1)
    end

    context 'with user role' do

      it 'should create 1 user' do
        expect{ run_import }.to change{User.count}.by(1)
      end

      it 'should create 1 role' do
        expect{ run_import }.to change{Role.count}.by(1)
      end

      it 'should create 1 role' do
        expect{ run_import }.to change{UserlessRole.count}.by(0)
      end

    end

    context 'with userless role' do
      let(:file){ uploaded_file('import/valid_teams_with_userless_role.xlsx') }

      it 'should create 1 user' do
        expect{ run_import }.to change{User.count}.by(0)
      end

      it 'should create 1 role' do
        expect{ run_import }.to change{Role.count}.by(0)
      end

      it 'should create 1 role' do
        expect{ run_import }.to change{UserlessRole.count}.by(1)
      end
    end
  end

  context 'invalid file' do
    describe 'invalid team but athletes are valid' do
      let(:file){ uploaded_file('import/invalid_teams_valid_athletes.xlsx') }

      it 'should create 0 team' do
        expect{ run_import }.to change{Team.count}.by(0)
      end

      it 'should create 0 user' do
        expect{ run_import }.to change{User.count}.by(0)
      end

      it 'should create 0 role' do
        expect{ run_import }.to change{Role.count}.by(0)
      end

      it 'should have failed context' do
        expect(run_import.failure?).to be true
      end

      it 'should have 1 failed team' do
        expect(run_import.failed_teams.count).to be == 1
      end

      it 'should have 1 failed athlete' do
        expect(run_import.failed_athletes.count).to be == 1
      end

      it 'should contain error csv' do
        expect(run_import.error_xls).to be_present
      end
    end
  end

end