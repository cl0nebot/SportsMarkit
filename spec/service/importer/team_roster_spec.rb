require 'rails_helper'

RSpec.describe Importer::TeamRoster do
  before do
    Geocoding.stub_geocoding
  end

  let(:school){ create :school }
  let(:run_import){ Importer::TeamRoster.call(file: file, teamable: school) }
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

    context 'with fixed errors' do
      let(:file){ uploaded_file('import/valid_teams_with_fixed_errors.xlsx') }

      it 'should create 1 team' do
        expect{ run_import }.to change{Team.count}.by(1)
      end

      it 'should create 1 user' do
        expect{ run_import }.to change{User.count}.by(1)
      end

      it 'should create 1 role' do
        expect{ run_import }.to change{Role.count}.by(1)
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

    context 'valid team params and empty userless role ' do
      let(:file){ uploaded_file('import/valid_teams_with_userless_empty_role.xlsx') }

      it 'should create 1 team' do
        expect{ run_import }.to change{Team.count}.by(1)
      end

      it 'should create 0 user' do
        expect{ run_import }.to change{User.count}.by(0)
      end

      it 'should create 0 role' do
        expect{ run_import }.to change{Role.count}.by(0)
      end

      it 'should create 0 userless role' do
        expect{ run_import }.to change{UserlessRole.count}.by(0)
      end

      it 'should have failed context' do
        expect(run_import.failure?).to be true
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

    describe 'valid team but athletes are invalid' do
      context 'invalid team params on athlete page' do
        let(:file){ uploaded_file('import/valid_teams_invalid_athletes.xlsx') }

        it 'should create 1 team' do
          expect{ run_import }.to change{Team.count}.by(1)
        end

        it 'should create 0 user' do
          expect{ run_import }.to change{User.count}.by(0)
        end

        it 'should create 0 role' do
          expect{ run_import }.to change{Role.count}.by(0)
        end

        it 'should create 0 userless role' do
          expect{ run_import }.to change{UserlessRole.count}.by(0)
        end

        it 'should have failed context' do
          expect(run_import.failure?).to be true
        end

        it 'should have 0 failed team' do
          expect(run_import.failed_teams.count).to be == 0
        end

        it 'should have 1 failed athlete' do
          expect(run_import.failed_athletes.count).to be == 1
        end

        it 'should contain error csv' do
          expect(run_import.error_xls).to be_present
        end
      end

      context 'valid team params but invalid user params on athlete page' do
        let(:file){ uploaded_file('import/valid_teams_invalid_athletes.xlsx') }

        it 'should create 1 team' do
          expect{ run_import }.to change{Team.count}.by(1)
        end

        it 'should create 0 user' do
          expect{ run_import }.to change{User.count}.by(0)
        end

        it 'should create 0 role' do
          expect{ run_import }.to change{Role.count}.by(0)
        end

        it 'should create 0 userless role' do
          expect{ run_import }.to change{UserlessRole.count}.by(0)
        end

        it 'should have failed context' do
          expect(run_import.failure?).to be true
        end

        it 'should have 0 failed team' do
          expect(run_import.failed_teams.count).to be == 0
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
end