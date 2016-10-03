# The `project` input will create a new project with a project name and a target dollar amount.
desc 'project <name> <target_amount>'
task project: :environment do
  prepare_args
  project = Project.create(name: ARGV[1], target_amount: ARGV[2])
  abort "ERROR: #{project.errors.full_messages}" unless project.valid?
  puts "Added #{project.name} project with target of #{project.target_amount.to_dollars}"
end

# The `back` input will back a project with a given name of the backer,
# the project to be backed, a credit card number and a backing dollar amount.
desc 'back <given_name> <project> <credit_card_number> <backer_amount>'
task back: :environment do
  prepare_args
  project = Project.find_by(name: ARGV[2])
  abort 'ERROR: No project exists with that name' unless project

  backer = project.backers.create(given_name: ARGV[1], credit_card_number: ARGV[3], backing_amount: ARGV[4])
  abort "ERROR: #{backer.errors.full_messages}" unless backer.valid?
  puts "#{backer.given_name} backed project #{project.name} for #{backer.backing_amount.to_dollars}"
end

# The `list` input will display a project including backers and backed amounts.
desc 'list <project>'
task list: :environment do
  prepare_args
  project = Project.find_by(name: ARGV[1])
  abort 'ERROR: No project exists with that name' unless project

  remaining_balance = project.target_amount
  project.backers.each do |backer|
    remaining_balance -= backer.backing_amount
    puts "-- #{backer.given_name} backed for #{backer.backing_amount.to_dollars}"
  end

  puts "#{project.name} needs #{remaining_balance.to_dollars} to be successfull"
end

# The `backer` input will display a list of projects that a backer has backed
# and the amounts backed.
desc 'backer <given name>'
task backer: :environment do
  prepare_args
  backer = Backer.find_by(given_name: ARGV[1])
  abort 'ERROR: No backer with that name exists' unless backer
  puts "-- Backed #{backer.project.name} for $#{backer.backing_amount.to_dollars}"
end

private

# http://cobwwweb.com/4-ways-to-pass-arguments-to-a-rake-task
def prepare_args
  ARGV.each { |a| task a.to_sym }
end
