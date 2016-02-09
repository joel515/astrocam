class Image < ActiveRecord::Base
  validates :sharpness,  presence: true,
                         numericality: { only_integer: true,
                                         greater_than_or_equal_to: -100,
                                         less_than_or_equal_to: 100 }
  validates :contrast,  presence: true,
                        numericality: { only_integer: true,
                                        greater_than_or_equal_to: -100,
                                        less_than_or_equal_to: 100 }
  validates :brightness, presence: true,
                         numericality: { only_integer: true,
                                         greater_than_or_equal_to: 0,
                                         less_than_or_equal_to: 100 }
  validates :saturation, presence: true,
                         numericality: { only_integer: true,
                                         greater_than_or_equal_to: -100,
                                         less_than_or_equal_to: 100 }
  validates :speed,      presence: true,
                         numericality: { only_integer: true,
                                         greater_than_or_equal_to: 1,
                                         less_than_or_equal_to: 6000000 }
  validates :iso,        presence: true

  LIBPATH = "/usr/local/lib"

  ISO_VALUES = [0, 100, 160, 200, 250, 320, 400, 500, 640, 800]

  validates_inclusion_of :iso, in: ISO_VALUES

  def self.start_stream
    puts "Starting mjpeg_streamer..."
    cmd = "LD_LIBRARY_PATH=#{LIBPATH} mjpg_streamer -b " \
      "-i \"input_raspicam.so -vf\" " \
      "-o \"output_http.so -p 8080 -w /usr/local/www\""
    `#{cmd}`
    puts "mjpeg_streamer started."
  end

  def self.stop_stream
    puts "Stopping mjpg_streamer..."
    cmd = "killall mjpg_streamer"
    `#{cmd}`
    puts "mjpg_streamer stopped."
  end

  def self.restart_stream(args)
    stop_stream
    start_stream(args)
  end

  def self.running?
    pid = `ps -A | grep mjpg_streamer | grep -v "grep" | grep -v mjpg_streamer. | awk '{print $1}' | head -n 1`
    pid.empty? ? false : true
  end
end
