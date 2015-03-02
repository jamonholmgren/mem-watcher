class MemWatcher
  attr_accessor :memory
  attr_accessor :cpu
  attr_accessor :frame

  def self.watch(args={})
    new.watch(args)
  end

  def watch(args={})
    return false unless correct_env?(args)
    self.frame = args[:frame] || [[ 5, 20 ], [ 50, 24 ]]
    parent_view = args[:parent_view] if args[:parent_view]
    parent_view ||= UIApplication.sharedApplication.delegate.window if UIApplication.sharedApplication.delegate.respond_to?(:window)
    parent_view || abort("MemWatcher needs a `parent_view:` view or access to the window in your AppDelegate via a `window` accessor.")
    parent_view.addSubview label
    print "Starting MemWatcher..."
    start_watcher
    puts "done."
  end

  def label
    @label ||= begin
      l = UILabel.alloc.initWithFrame(self.frame)
      l.backgroundColor = UIColor.colorWithWhite(1.0, alpha: 0.8)
      l.layer.cornerRadius = 5
      l.layer.masksToBounds = true
      l.font = UIFont.systemFontOfSize(10.0)
      l.text = "Loading..."
      l.sizeToFit
      l
    end
  end

  private

  def correct_env?(args={})
    args[:env] ||= [ "development" ]
    Array(args[:env]).map(&:to_s).include?(RUBYMOTION_ENV)
  end

  def start_watcher
    every 1 do
      self.cpu, self.memory = cpu_memory
      label.text = "#{self.memory} MB #{self.cpu}%"
      label.sizeToFit
      label.superview.bringSubviewToFront(label)
    end
  end

  def every(interval, user_info=nil, &fire)
    NSTimer.scheduledTimerWithTimeInterval(interval, target: fire, selector: 'call:', userInfo: user_info, repeats: true)
  end

  def pid
    @pid ||= Process.pid
  end

  def cpu_memory
    output = `ps -p #{pid} -o %cpu,%mem`
    output.split("\n").last.strip.split(" ").map(&:strip)
  end

end

