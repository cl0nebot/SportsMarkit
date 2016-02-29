module FileUpload
  def uploaded_file(path)
    file = File.new(Rails.root.join('spec/fixtures/files', path))
    file.rewind
    ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
  end
end

RSpec.configure do |c|
  c.include FileUpload
end
