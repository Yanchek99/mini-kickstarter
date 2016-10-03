require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  setup do
    @project = projects(:awesome_sauce)
    assert @project.valid?, @project.errors.full_messages
  end

  test 'Projects should be alphanumeric and allow underscores or dashes.' do
    @project.name = 'test-dashes'
    assert @project.valid?, @project.errors.full_messages
    @project.name = 'test_underscores'
    assert @project.valid?, @project.errors.full_messages
    @project.name = 'none a1phanum3ric'
    assert_not @project.valid?, @project.errors.full_messages
  end

  test 'Projects should be no shorter than 4 characters but no longer than 20 characters.' do
    @project.name = '123'
    assert_not @project.valid?, @project.errors.full_messages
    @project.name = '123456789012345678901'
    assert_not @project.valid?, @project.errors.full_messages
  end

  test 'Target dollar amounts should accept both dollars and cents' do
    @project.target_amount = 1
    assert @project.valid?, @project.errors.full_messages
    @project.target_amount = '.01'
    assert @project.valid?, @project.errors.full_messages
    @project.target_amount = 1.01
    assert @project.valid?, @project.errors.full_messages
  end

  test 'Target dollar amounts should NOT use the $ currency symbol to avoid issues with shell escaping.' do
    @project.target_amount = '$1.99'
    assert_not @project.valid?, @project.errors.full_messages
  end
end
