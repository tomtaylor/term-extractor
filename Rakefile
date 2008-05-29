# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'term_extractor'

task :default => 'spec:run'

PROJ.name = 'term_extractor'
PROJ.authors = 'Tom Taylor'
PROJ.email = 'tom@headshift.com'
PROJ.url = 'http://www.example.com'
PROJ.rubyforge.name = 'termextractor'
PROJ.version = TermExtractor::VERSION

PROJ.spec.opts << '--color'

depend_on 'hpricot'

# EOF
