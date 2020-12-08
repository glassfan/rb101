def prompt(message)
  Kernel.puts("=> #{message}")
end

def number_valid?(num)
  num.to_i != 0
end

def operation_to_msg(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt("Welcome to the Simple Calulator! Please Enter your name:")
name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt("Please enter a valid name.")
  else
    break
  end
end

prompt("Welcome, #{name}!")
loop do # main loop
  number1 = ''
  loop do
    prompt("Enter the first number: ")
    number1 = Kernel.gets().chomp()
    if number_valid?(number1)
      break
    else
      prompt("Error, not a valid number")
    end
  end
  number2 = ''
  loop do
    prompt("Enter the second number: ")
    number2 = Kernel.gets().chomp()
    if number_valid?(number2)
      break
    else
      prompt("Error, not a valid number")
    end
  end
  operator_prompt = <<-MSG
  Enter an operation to perform: 
    1)add 
    2)subtract 
    3)multiply 
    4)divide
  MSG
  prompt(operator_prompt)
  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    break if %w(1 2 3 4).include?(operator)
    prompt("must choose 1) 2) 3) 4)")
  end
  prompt("#{operation_to_msg(operator)} the two numbers...")
  case operator
  when '1'
    result = number1.to_i() + number2.to_i()
  when '2'
    result = number1.to_i() - number2.to_i()
  when '3'
    result = number1.to_i() * number2.to_i()
  when '4'
    result = number1.to_f() / number2.to_f()
  end
  prompt("Result is: #{result}")
  prompt("Do you want to make another calculation? Y/N")
  reply = Kernel.gets().chomp().downcase()
  break unless reply.start_with?('y')
end
prompt("Thank you for using Simple Calculator!")
