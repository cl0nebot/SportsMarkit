require 'rails_helper'

RSpec.describe Importer::Team do
  before do
    Geocoding.stub_geocoding
  end

  let(:school){ create :school }
  let(:run_import){ Importer::Team.call(file: file, teamable: school) }

  context 'valid file' do
    let(:file){ uploaded_file('import/valid_teams.xlsx') }

    it 'should create 1 team' do
      expect{ run_import }.to change{Team.count}.by(1)
    end

    context 'with fixed errors' do
      let(:file){ uploaded_file('import/valid_only_teams_with_fixed_errors.xlsx') }

      it 'should create 1 team' do
        expect{ run_import }.to change{Team.count}.by(1)
      end
    end
  end

  context 'invalid file' do
    describe 'invalid team but athletes are valid' do
      let(:file){ uploaded_file('import/invalid_teams.xlsx') }

      it 'should create 0 team' do
        expect{ run_import }.to change{Team.count}.by(0)
      end
    end
  end
end