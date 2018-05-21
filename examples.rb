require_relative 'lib/enumerator_generate'
require 'pp'

# Infinite sequence
p Enumerator.generate(1, &:succ).take(5)

# Easy Fibonacci
p Enumerator.generate([0, 1]) { |f0, f1| [f1, f0 + f1] }.take(10).map(&:first)

require 'date'

# Find next Tuesday
p Enumerator.generate(Date.today, &:succ).detect { |d| d.wday == 2 }

require 'nokogiri'
require 'open-uri'

# Find some element on page, then make list of all parents
p Nokogiri::HTML(open('https://www.ruby-lang.org/en/'))
  .at('a:contains("Ruby 2.2.10 Released")')
  .yield_self { |node| Enumerator.generate(node, &:parent) } # Enumerator#generate is a bit wordy in chains
  .take_while { |node| node.respond_to?(:parent)  }
  .map(&:name)

require 'octokit'

Octokit.stargazers('rails/rails')
# ^ this method returned just an array, but have set `.last_response` to full response, with data
# and pagination. So now we can do this:
p Enumerator.generate(Octokit.last_response) { |response| response.rels[:next].get } # pagination: `get` fetches next Response
  .first(3) # take just 3 pages of stargazers
  .flat_map(&:data) # data is parsed response content (stargazers themselves)
  .map { |h| h[:login] }

# No initial value: random search
target = 7
p Enumerator.generate { rand(10) }.take_while { |i| i != target }.to_a

# No initial value: external while condition
require 'strscan'
scanner = StringScanner.new('7+38/6')
p Enumerator.generate { scanner.scan(%r{\d+|[-+*/]}) }.take_while { !scanner.eos? }.to_a


# Potential message loop system:
# Enumerator.generate { Message.receive }.take_while { |msg| msg != :exit }