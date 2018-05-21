class Enumerator
  NOVALUE = Object.new.freeze

  def self.generate(initial = NOVALUE)
    raise ArgumentError, "No block given" unless block_given?
    Enumerator.new do |y|
      val = initial == NOVALUE ? yield() : initial
      y << val

      loop do
        val = yield(val)
        y << val
      end
    end
  end
end