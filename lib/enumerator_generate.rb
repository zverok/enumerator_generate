class Enumerator
  NOVALUE = Object.new.freeze

  def self.generate(initial = NOVALUE)
    raise ArgumentError, "No block given" unless block_given?
    Enumerator.new do |y|
      val = initial == NOVALUE ? yield() : initial

      loop do
        y << val
        val = yield(val)
      end
    end
  end
end