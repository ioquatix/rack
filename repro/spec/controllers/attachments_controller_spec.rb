require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  describe 'POST #create' do
    it 'uploads a file successfully' do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/fixture_file.json'), 'text/plain')

      post :create, params: { attachment: { attachment: file } }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['message']).to eq('File uploaded successfully')
    end

    it 'returns an error if the file is not attached' do
      post :create, params: { attachment: { attachment: nil } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("Attachment can't be blank")
    end
  end
end