require 'yaml'
MESSAGES = YAML.load_file('mortgage_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def number_valid?(num)
  /\d/.match(num) && /^-?\d*\.?\d*$/.match(num)
end

def str_to_number(str_num)
  if str_num.include? "."
    str_num.to_f
  else
    str_num.to_i
  end
end

def trim_lead_zeroes(str)
  str.sub!(/^0+/, "")
end

def get_user_input(message, num_type, err_msg)
  user_input = ''
  loop do
    prompt(MESSAGES[message])
    user_input = gets.chomp
    if number_valid?(user_input)
      trim_lead_zeroes(user_input)
      user_input = str_to_number(user_input)
      case num_type
      when 'loan_duration'
        next if user_input.is_a? Float
      else
        next if user_input == 0 || user_input < 0
      end
      break
    else prompt(MESSAGES[err_msg])
    end
  end
  user_input
end

def again?
  loop do
    prompt(MESSAGES['another'])
    reply = gets.chomp.downcase
    if reply == 'y'
      break true
    elsif reply == 'n'
      break false
    else
      next
    end
  end
end

def display_calculations(loan_amount, apr, mir, loan_duration, monthly_payment)
  puts "------------ Loan Summary ---------------------"
  puts "Loan Amount:                      $#{loan_amount}"
  puts "Annual Percentage Rate:           $#{format('%.3f', apr)}%"
  puts "Monthly Percentage Rate:          $#{format('%.4f', mir)}%"
  puts "Loan Duration:                    #{loan_duration} years"
  puts "Monthly Payment:                  $#{format('%.2f', monthly_payment)}"
  puts "-----------------------------------------------"
end
prompt(MESSAGES['welcome'])

# Main loop
loop do
  loan_amount = get_user_input('loan_amount', 'loan_amount', 'error_loan')
  apr = get_user_input('apr', 'apr', 'error_apr')
  loan_duration = get_user_input('loan_duration',
                                 'loan_duration',
                                 'error_loan_duration')
  mir = (apr * 0.01) / 12.0
  months_duration = loan_duration * 12
  monthly_payment = loan_amount * (mir / (1 - (1 + mir)**(-months_duration)))
  display_calculations(loan_amount, apr, mir, loan_duration, monthly_payment)
  break unless again?
end

prompt(MESSAGES['exit'])
