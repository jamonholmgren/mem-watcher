class MemWatcher

  def self.watch(args={})
    new.watch(args)
  end

  def watch(args={})
    return false unless correct_env?(args)
    parent_view = args[:parent_view] if args[:parent_view]
    parent_view ||= UIApplication.sharedApplication.delegate.window if UIApplication.sharedApplication.delegate.respond_to?(:window)
    parent_view || abort("MemWatcher needs a `display_on:` view or access to the window in your AppDelegate via a `window` accessor.")
    parent_view.addSubview label
    label.text = "Loading..."
    start_watcher
  end

  private

  def correct_env?(args={})
    args[:env] ||= [ "development" ]
    Array(args[:env]).map(&:to_s).include?(RUBYMOTION_ENV)
  end

  def start_watcher
    every 1 do
      cpu, memory = cpu_memory
      label.text = "#{memory} MB #{cpu}%"
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

  def label
    @label ||= begin
      l = UILabel.alloc.initWithFrame([[ 10, 10 ], [ 50, 24 ]])
      l.backgroundColor = UIColor.colorWithWhite(1.0, alpha:0.5)
      l.font = UIFont.systemFontOfSize(10.0)
      l.sizeToFit
      l
    end
  end

end

