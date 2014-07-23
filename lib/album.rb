require 'pathname'

class Album
  attr_reader :name, :host

  def initialize(name, settings)
    @name = name
    @host = settings[:host]
  end

  def random(count=1)
    images.sample(count)
  end

  def images
    @images ||= Pathname.glob("public/images/#{self.name}/*").map{|i| "#{self.host}/#{path}/#{i.basename}"}
  end

  def path
    "images/#{self.name}"
  end

  def self.list
    Pathname.glob("public/images/*").map{|d| d.basename.to_s}
  end
end
