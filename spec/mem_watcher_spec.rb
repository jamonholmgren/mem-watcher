describe MemWatcher do
  it "has no meaninful tests" do
    MemWatcher.should.respond_to(:watch)
    MemWatcher.new.should.respond_to(:watch)
  end
  it "is provided with no warranty, express or implied" do
    MemWatcher.new.should.be.kind_of(MemWatcher)
  end
  it "could and probably will break your app in strange and wonderful ways" do
    MemWatcher.new.private_methods.should.include(:cpu_memory)
  end
  it "will hopefully still be useful to someone someday" do
    cpu, mem = MemWatcher.new.send(:cpu_memory)
    cpu.to_f.should.be > 0.0
    mem.to_f.should.be > 0.0
  end
end
