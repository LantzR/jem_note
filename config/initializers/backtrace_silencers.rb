# Be sure to restart your server when you modify this file.

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Rails.backtrace_cleaner.add_silencer { |line| line =~ (/rspec-core | 
                                                           ruby_executable_hooks/)
                                        }
#  Rails.backtrace_cleaner.add_silencer { |line| line =~ /ruby_executable_hooks/ }

# Rails.backtrace_cleaner.add_silencer { |line| line =~ /runner/ }
#  Rails.application_trace

  #Rails.backtrace_cleaner.add_filter { |line| line =~ /runner.rb/ }
# Rails.backtrace_cleaner.add_silencer { |line| line =~ /my_noisy_library/ }

# You can add backtrace silencers for libraries that you're using but don't wish to see in your backtraces.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# You can also remove all the silencers if you're trying to debug a problem that might stem from framework code.
# Rails.backtrace_cleaner.remove_silencers!

# - Intended for rails console 
# 

# http://archive.railsforum.com/viewtopic.php?id=41146
# works in irb
#context.back_trace_limit=0
#Rails.backtrace_cleaner.back_trace_limit=0
