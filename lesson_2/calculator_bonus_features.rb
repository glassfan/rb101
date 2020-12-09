require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def number_valid?(num)
  /\d/.match(num) && /^-?\d*\.?\d*$/.match(num)
end

def number_type(str_num)
  if str_num.include? "."
    str_num.to_f
  else
    str_num.to_i
  end
end

def operation_to_msg(op)
  word = case op
          when '1'
            'Adding'
          when '2'
            'Subtracting'
          when '3'
            'Multiplying'
          when '4'   
            'Dividing'
        end
    word
end

prompt(MESSAGES['welcome'])
name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt("Welcome, #{name}!")
loop do # main loop
  number1 = ''
  loop do
    prompt(MESSAGES['first_num'])
    number1 = gets.chomp
    if number_valid?(number1)
      number1 = number_type(number1)
      break
    else
      prompt(MESSAGES['not_valid'])
    end
  end
  number2 = ''
  loop do
    prompt(MESSAGES['second_num'])
    number2 = gets.chomp
    if number_valid?(number2)
      number2 = number_type(number2)
      break if number2 != 0
    else
      prompt(MESSAGES['not_valid'])
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
    operator = gets.chomp
    break if %w(1 2 3 4).include?(operator)
    prompt(MESSAGES['must_choose'])
  end
  prompt("#{operation_to_msg(operator)} the two numbers...")
  word = case operator
  when '1'
    result = number1 + number2
  when '2'
    result = number1 - number2
  when '3'
    result = number1 * number2 
  when '4'
    result = number1 / number2 
  end
  prompt(MESSAGES['result'] +"#{result}")
  prompt(MESSAGES['another'])
  reply = gets.chomp.downcase
  break unless reply.start_with?('y')
end
prompt(MESSAGES['exit'])
