class AttachmentsController < ApplicationController
  def create
    @attachment = Attachment.new(attachment_params)
    if @attachment.save
      render json: { message: 'File uploaded successfully' }, status: :created
    else
      render json: { errors: @attachment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @attachment = Attachment.find(params[:id])
    if @attachment.update(attachment_params)
      render json: { message: 'Attachment updated successfully' }, status: :ok
    else
      render json: { errors: @attachment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:attachment)
  end
end