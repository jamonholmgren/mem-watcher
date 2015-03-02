# MemWatcher

Helps you keep an eye on your RubyMotion iOS app's memory and CPU usage.

Adds a little UILabel in the top left of the screen that shows CPU % and memory usage in MB.

![screenshot](http://clrsight.co/jh/2015-03-02-lo7s3.png?+)

## Setup/Usage

```ruby
gem 'mem-watcher'
```

```ruby
class AppDelegate
  def application(app, didFinishLaunchingWithOptions: options)
    # ...
    MemWatcher.watch
    true
  end
end
```

### Options

The `env:` option controls the environments that will activate MemWatcher. It defaults to `"development"` and can be a string or array of acceptable RubyMotion environments.

```ruby
MemWatcher.watch(env: [ "development", "test" ])
```

If you want to attach the view to another view, provide it:

```ruby
MemWatcher.watch(parent_view: @my_other_view)
```

If you want to specify your own frame, provide it:

```ruby
MemWatcher.watch(frame: [[ 300, 600 ], [ 50, 50 ] ])
```

Note that the UILabel will `resizeToFit` every tick, so the size is irrelevant.

You can access the label directly if you want.

```ruby
watcher = MemWatcher.watch
watcher.label.backgroundColor = UIColor.blueColor
```

### Caveats

* It only reports on the current app main process.
* I have no idea how accurate it is. It does accurately show purposely introduced memory leaks, from what I can see.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT, yo.
