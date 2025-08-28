=begin
Write your code for the 'Raindrops' exercise in this file. Make the tests in
`raindrops_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/raindrops` directory.
=end

class Raindrops
  
  def self.convert(num)
    result = ""
    if num % 3 == 0 then
      result += "Pling"
    end
    if num % 5 == 0 then
      result += "Plang"
    end
    if num % 7 == 0 then
      result += "Plong"
    end

    if result == "" then
      "#{num}"
    else
      result
    end
  end

end
