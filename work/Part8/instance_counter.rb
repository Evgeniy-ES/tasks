module InstanceCounter
  module ClassMethods
    def instances(volume)
      count = 0
      volume.each {|unit| count += 1}
      count
    end
  end

  module InstanceMethods
    def register_instance(volume)
      count = add_count(volume)
    end

    protected
    def add_count(volume)
      count = 0
      volume.each {|unit| count += 1}
      count += 1
    end
  end

end
