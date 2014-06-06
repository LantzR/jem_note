require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JemNote
  class Application < Rails::Application
  
    # :sql instead of default :ruby.
    config.active_record.schema_format = :sql
    config.active_record.maintain_test_schema = true
    # ActiveRecord::Migration.maintain_test_schema!
    
    # - Seattle Time
    config.time_zone = 'Pacific Time (US & Canada)'

  #fubar
#    Rails.backtrace_cleaner.clean(exception.backtrace)
  end
end
