require 'bundler'
Bundler.require

require 'require_all'
require 'colorize'

require_all 'app/'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

ActiveRecord::Base.logger = nil
