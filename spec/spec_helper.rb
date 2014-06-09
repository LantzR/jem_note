# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

### db:test:prepare

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  
# - - - - - - - - - - - - - - - - - - - -
# Describe Database Helpers

### ZelBug = false
### ZelBug2 = false
 
  # - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Test for Expected Database Error

  def expect_db_error(error_message, &block)
  
    begin
      puts 'Starting count: ' + Jem.count.to_s if ZelBug2
      yield
    # - - - - - - - - - - - - - - - - - -  
    rescue ActiveRecord::RecordNotUnique => error_handle
      database_threw_error = true
      something_else_threw_error = false
      database_threw_NotUnique = true
      prt_db_dbg_msg('-- database - Not Unique', error_handle) if ZelBug
      
=begin - Wishful thinking  
    rescue ActiveRecord::CheckViolation => error_handle
      database_threw_error = true
      something_else_threw_error = false
      database_threw_Check = true
      prt_db_dbg_msg('-- database - CheckViolation', error_handle) if ZelBug  
=end

    rescue ActiveRecord::StatementInvalid => error_handle
      database_threw_error = true
      something_else_threw_error = false
      debugger  if ZelBug2
      original_error = error_handle.original_exception

      if original_error.is_a? PG::NotNullViolation
        database_threw_NotNull = true
        prt_db_dbg_msg('-- database error - NotNullViolation', original_error) if ZelBug
      elsif original_error.is_a? PG::StringDataRightTruncation
        database_threw_TooLong = true
        prt_db_dbg_msg('-- database error - Right Truncate - Too Long', original_error) if ZelBug
      elsif original_error.is_a? PG::CheckViolation
        database_threw_Check = true
        prt_db_dbg_msg('-- database error - CheckViolation', original_error) if ZelBug
      else        
        something_else_threw_error = true
        prt_db_dbg_msg('-- database error - Invalid', error_handle) if ZelBug
      end
      # ActiveRecord::StatementInvalid: PG::NotNullViolation:
      #  error_handle.original_exception.is_a? PG::NotNullViolation
    rescue  => error_handle
      something_else_threw_error = true
      puts error_handle
      prt_db_dbg_msg('-- === Other error ===', error_handle) if ZelBug
    # - - - - - - - - - - - - - - - - - - 
    ensure
      # Yulch
      if !something_else_threw_error && !database_threw_error
        something_else_threw_error = true
        database_Unknown_Unthrown_Error = true
        debugger if ZelBug2
        prt_db_dbg_msg('-- === Unknown Unthrown error ===', error_handle) if ZelBug
        # Issue with d12 & d15 and null allowed
      end  
   end
   
       if ZelBug
         puts 'Flag: somethingElse: '     + something_else_threw_error.to_s
         puts 'Flag: UnknownUnthrown: '   + database_Unknown_Unthrown_Error.to_s

         puts 'Flag: databaseError: '     + database_threw_error.to_s
         puts 'Flag: databaseNotNull: '   + database_threw_NotNull.to_s
         puts 'Flag: databaseNotUnique: ' + database_threw_NotUnique.to_s
         puts 'Flag: databaseCheck: '     + database_threw_Check.to_s
         puts 'Flag: databaseTooLong: '   + database_threw_TooLong.to_s
                     
         puts 'Ending count: ' + Jem.count.to_s + "\n\n" if ZelBug2
       end #ZelBug

    # - - - - - - - - - - - - - - - - - -  
    # Assertions for Database Spec
    assert !something_else_threw_error, "There is an error in our test code" 

    # Unknown and Unthrown error
    assert !database_Unknown_Unthrown_Error, "There is an Unknown and Unthrown error in our test code" 
    
    # Test that database did throw an error   
    assert database_threw_error && !something_else_threw_error, error_message
    
    # - - - - - - - - - - - - - - - - - - - - - -
    
    # - - - - - - - - - - - - - - - - - - - - - -
    # XRef: http://enterpriserails.chak.org/full-text/
    #         chapter-5-building-a-solid-data-model
    # - - - - - - - - - - - - - - - - - - - - - -
  end
  
    # - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Print Database Debug Messages
  def prt_db_dbg_msg(printMsg, error_handle)
    puts '-- db debug msg'
    puts printMsg
    puts error_handle.inspect
    puts error_handle.class.ancestors.inspect
  end
  


# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 



# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
