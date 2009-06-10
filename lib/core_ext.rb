module Kernel
  def returning(object)
    yield(object)
    object
  end
end

class Object
  def tap
    yield(self)
    self
  end
end