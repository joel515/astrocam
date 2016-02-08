class Image < ActiveRecord::Base

  LIBPATH = "/usr/local/lib"

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
    unless pid.nil?
      puts "mjpg_streamer is running with pid #{pid}"
      puts "mjpg_streamer was started with the following command line"
      puts `cat /proc/#{pid}/cmdline`
      true
    else
      puts "Could not find mjpg_streamer running"
      false
    end
  end
end
