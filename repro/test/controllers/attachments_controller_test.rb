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
  
  def setup
    @attachment = attachments(:one) # Assuming you have a fixture for attachments
  end

  test 'should update the attachment successfully' do
    file = fixture_file_upload('fixture_file.json', 'text/plain')

    patch attachment_url(@attachment), params: { attachment: { attachment: file } }

    assert_response :ok
    assert_equal 'Attachment updated successfully', JSON.parse(@response.body)['message']
  end

  test 'should return an error if the file is not attached during update' do
    patch attachment_url(@attachment), params: { attachment: { attachment: nil } }

    assert_response :unprocessable_entity
    assert_includes JSON.parse(@response.body)['errors'], "Attachment can't be blank"
  end
end
