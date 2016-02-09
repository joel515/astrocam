class ImagesController < ApplicationController
  before_action :set_image, only: [:viewer]

  def viewer
  end

  def start
    Image.start_stream unless Image.running?
    respond_to do |format|
      format.html { render 'viewer' }
      format.js
    end
  end

  def stop
    Image.stop_stream if Image.running?
    respond_to do |format|
      format.html { render 'viewer' }
      format.js
    end
  end

  private

    def set_image
      @image = Image.find(params[:id]) unless params[:id].nil?
    end
end
