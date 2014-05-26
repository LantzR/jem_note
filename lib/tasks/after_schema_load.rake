# NOTE: Rails does not allow other primary keys to be defined 
#       so we have to do it here

namespace :jem_note do
  namespace :db do
    task :after_schema_load => :environment do
      puts '-- adding primary key for jems'
      query = 'Alter Table jems Add Primary Key (name);'
      ActiveRecord::Base.connection.execute(query)
    end
  end
end

Rake::Task['db:schema:load'].enhance do
  ::Rake::Task['jem_note:db:after_schema_load'].invoke
end
# - - - - - - - - - - - - - - - - - - - -
# http://www.lshift.net/blog/2013/09/30/changing-the-primary-key-type
#      -in-ruby-on-rails-models/comment-page-1
# - - - - - - - - - - - - - - - - - - - -
