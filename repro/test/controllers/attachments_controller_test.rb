require 'test_helper'

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  include ActionDispatch::TestProcess

  test 'should upload a file successfully' do
    file = fixture_file_upload('fixture_file.json', 'text/plain')

    post attachments_url, params: { attachment: { attachment: file } }

    assert_response :created
    assert_equal 'File uploaded successfully', JSON.parse(@response.body)['message']
  end

  test 'should return an error if the file is not attached' do
    post attachments_url, params: { attachment: { attachment: nil } }

    assert_response :unprocessable_entity
    assert_includes JSON.parse(@response.body)['errors'], "Attachment can't be blank"
  end
end