require 'yaml'
MESSAGES = YAML.load_file('mortgage_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def number_valid?(num)
  /\d/.match(num) && /^-?\d*\.?\d*$/.match(num)
end

def number_cast(str_num)
  if str_num.include? "."
    str_num.to_f
  else
    str_num.to_i
  end
end

def trim_lead_zeroes(str)
  str.sub!(/^0+/, "")
end

prompt(MESSAGES['welcome'])

loop do
  loan_amount = ''
  loop do
    prompt(MESSAGES['loan_amount'])
    loan_amount = gets.chomp
    if number_valid?(loan_amount)
      trim_lead_zeroes(loan_amount)
      loan_amount = number_cast(loan_amount)
      next if loan_amount == 0 || loan_amount < 0
      break
    else
      prompt(MESSAGES['error_loan'])
    end
  end

  apr = ''
  loop do
    prompt(MESSAGES['apr'])
    apr = gets.chomp
    if number_valid?(apr)
      trim_lead_zeroes(apr)
      apr = number_cast(apr) * 0.01
      next if apr == 0 || apr < 0
      break
    else
      prompt(MESSAGES['error_apr'])
    end
  end

  loan_duration = ''
  loop do
    prompt(MESSAGES['loan_duration'])
    loan_duration = gets.chomp
    if number_valid?(loan_duration)
      trim_lead_zeroes(loan_duration)
      loan_duration = number_cast(loan_duration)
      next if loan_duration == 0 || loan_duration < 0
      break
    else
      prompt(MESSAGES['error_loan_duration'])
    end
  end
  mir = apr / 12.0
  months_duration = loan_duration * 12.0
  monthly_payment = loan_amount * (mir / (1 - (1 + mir)**(-months_duration)))

  puts "############## Loan Summary #############"
  puts "Loan Amount: $#{loan_amount}"
  puts "Annual Percentage Rate: #{apr}%"
  puts "Monthly Percentage Rate: #{mir}%"
  puts "Loan Duration: #{loan_duration} years"
  puts "Monthly Payment: $#{format('%.2f', monthly_payment)}"
  puts "#########################################"

  prompt(MESSAGES['another'])
  reply = gets.chomp.downcase
  break unless reply.start_with?('y')
end

prompt(MESSAGES['exit'])
