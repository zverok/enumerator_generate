# `Enumerator#generate`

This is an alternative to [`Object#enumerate`](https://github.com/zverok/object_enumerate) Ruby language core proposal. Goal is the same: generating enumerators which can idiomatically replace (most of) `while` and `loop` cycles.

After some experiments, it turns out that "start from initial value, and continue with this block" (like `Object#enumerate` does) is not the only important use case. "Just enumerate with this block" is equally important, and `Enumerator#generate` supports this case finely. Also, the call sequence seems to be less confusing, it is pretty straight: `Enumerator#generate` generates an enumerator from block and optional initial value.

## Synopsys

`Enumerator#generate` takes a block and optional initial value, and generates (infinite) enumerator by applying the block to result of previous iteration. If initial value is not passed, first block receives no arguments.

## Examples of usage

### With initial value

```ruby
# Infinite sequence
p Enumerator.generate(1, &:succ).take(5)
# => [1, 2, 3, 4, 5]

# Easy Fibonacci
p Enumerator.generate([0, 1]) { |f0, f1| [f1, f0 + f1] }.take(10).map(&:first)
#=> [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]

require 'date'

# Find next Tuesday
p Enumerator.generate(Date.today, &:succ).detect { |d| d.wday == 2 }
# => #<Date: 2018-05-22 ((2458261j,0s,0n),+0s,2299161j)>
```
(Other examples from [`Object#enumerate`](https://github.com/zverok/object_enumerate) are easily translated, too.)

### Without initial value

```ruby
# Random search
target = 7
p Enumerator.generate { rand(10) }.take_while { |i| i != target }.to_a
# => [0, 6, 3, 5,....]

# External while condition
require 'strscan'
scanner = StringScanner.new('7+38/6')
p Enumerator.generate { scanner.scan(%r{\d+|[-+*/]}) }.take_while { !scanner.eos? }.to_a
# => ["7", "+", "38", "/"]

# Potential message loop system:
Enumerator.generate { Message.receive }.take_while { |msg| msg != :exit }
```