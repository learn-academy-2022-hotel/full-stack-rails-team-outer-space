# As a developer, I need each Account password to have at least one number.
# HINT: Read about custom validations in the Active Record validation docs.

# Create file `app/validators/custom_validation.rb`

# custom class that inherits from ActiveModel::Validator which must implement validate method
class CustomValidation < ActiveModel::Validator
  # validate method that takes in a data entry and produces a message if the password does not contain a number
  def validate(data_entry)
    # in unless statement, the block of code executes when the condition is false.
    # =~ is Ruby's basic pattern-matching operator
    # // is for regex to test whether a string contains a given pattern
    # \d is a metacharacter that matches any digit from 0 to 9.
    unless data_entry.password =~ /\d/
      # adds a custom error message
      data_entry.errors.add :password, 'Must include a number in your password!'
    end
  end
end

# By default, Rails filters out passwords by adding the following filters in config/initializers/filter_parameter_logging.rb. When printing the entry, the value will appear as [FILTERED].