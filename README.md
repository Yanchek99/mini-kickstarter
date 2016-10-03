# README
Using Ruby on Rails for this project, it may be a bit heavy for this particular application but it includes a lot of libraries that make getting started easy. (ORM, Rake, etc)

# Ruby version
- 2.3.1

# System Requirements
- bundle gem `gem install bundle`

# Configuration

# Setup
- run `bundle install`

# Database Creation
- SQLite is enabled for development mode to ensure easy setup.
- Run `rake db:setup` (If this is the first time you are setting the app up, else run `rake db:migrate`)

# Unit Testing
- run `rake test`

# Static Code Analysis
- run `rubocop`

# Running command line tasks
- Leveraging rake here so ensure all commands are prefixed with rake. Ex. `rake list Awesome_Sauce`
