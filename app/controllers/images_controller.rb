class ImagesController < ApplicationController
  # before_action :set_image, only: [:viewer]

  def viewer
    @image ||= Image.new
  end

  def start
    Image.start_stream
    render 'viewer'
  end

  def stop
    Image.stop_stream
    render 'viewer'
  end

  private

    def set_image
      @image = Image.find(params[:id])
    end
end
