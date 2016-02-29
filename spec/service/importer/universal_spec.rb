require 'rails_helper'

RSpec.describe Importer::Team do


  def uploaded_file(path)
    file = File.new(Rails.root.join('spec/fixtures/files', path))
    file.rewind
    ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
  end

  [Club, Facility, League, School].each do |target|
    context "#{target.to_s}" do
      let(:run_import){ Importer::Universal.call(file: file, model: target) }

      context "valid #{target.to_s.underscore}" do
        let(:file){ uploaded_file("import/valid_#{target.to_s.pluralize.underscore}.xlsx") }

        it "should create 1 #{target.to_s.underscore}" do
          expect{ run_import }.to change{ target.count }.by(1)
        end
      end

      context "invalid #{target.to_s.underscore}" do
        let(:file){ uploaded_file("import/invalid_#{target.to_s.pluralize.underscore}.xlsx") }

        it "should not create #{target.to_s.underscore}" do
          expect{ run_import }.to change{ target.count }.by(0)
        end

        it "should have failed context" do
          expect(run_import.failure?).to be true
        end

        it 'should have 1 failed athlete' do
          expect(run_import.failed_records.count).to be == 1
        end

        it 'should contain error csv' do
          expect(run_import.error_xls).to be_present
        end
      end
    end
  end
end