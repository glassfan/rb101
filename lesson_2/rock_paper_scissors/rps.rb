VALID_CHOICES = %w(rock paper scissors)

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
  (first == 'paper' && second == 'rock')  ||
  (first == 'scissors' && second == 'paper') 
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won")
  elsif win?(computer, player)
    prompt("You Lost")
  else
    prompt("Tie!")
  end
end

choice = ''
loop do
  prompt("Choose one: #{VALID_CHOICES.join(', ')}")
  choice = gets.chomp
  if VALID_CHOICES.include?(choice)
    break
  else
    prompt("Error, invalid entry....")
  end
end
computer_choice = VALID_CHOICES.sample
puts "You chose: #{choice}; Computer chose: #{computer_choice}"
display_results(choice, computer_choice)
