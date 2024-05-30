FactoryBot.define do
  factory :attachment do
    attachment { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/fixture_file.json'), 'text/plain') }
  end
end