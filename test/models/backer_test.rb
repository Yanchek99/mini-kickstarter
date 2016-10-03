require 'test_helper'

class BackerTest < ActiveSupport::TestCase
  setup do
    @backer = backers(:john)
    assert @backer.valid?, @backer.errors.full_messages
  end

  test 'Given names should be alphanumeric and allow underscores or dashes.' do
    @backer.given_name = 'test-dashes'
    assert @backer.valid?, @backer.errors.full_messages
    @backer.given_name = 'test_underscores'
    assert @backer.valid?, @backer.errors.full_messages
    @backer.given_name = 'none alpha'
    assert_not @backer.valid?
  end

  test 'Given names should be no shorter than 4 characters but no longer than 20 characters.' do
    @backer.given_name = '123'
    assert_not @backer.valid?, @backer.errors.full_messages
    @backer.given_name = '123456789012345678901'
    assert_not @backer.valid?, @backer.errors.full_messages
  end

  test 'Credit card numbers may vary in length, up to 19 characters.' do
    @backer.credit_card_number = '12345678901234567890'
    assert_not @backer.valid?, @backer.errors.full_messages
    @backer.credit_card_number = '41111'
    assert @backer.valid?, @backer.errors.full_messages
  end

  test 'Credit card numbers will always be numeric.' do
    @backer.credit_card_number = '123fgb'
    assert_not @backer.valid?, @backer.errors.full_messages
  end

  test 'Card numbers should be validated using Luhn-10.' do
    @backer.credit_card_number = '5555555555554444'
    assert @backer.valid?, @backer.errors.full_messages
    @backer.credit_card_number = '1234567890123456'
    assert_not @backer.valid?, @backer.errors.full_messages
  end

  test 'Cards that have already been added will display an error' do
    dup_backer = Backer.new(given_name: 'dupe', project: @backer.project, credit_card_number: @backer.credit_card_number, backing_amount: 20)
    assert_not dup_backer.valid?, dup_backer.errors.full_messages
  end

  test 'Backing dollar amounts should accept both dollars and cents' do
    @backer.backing_amount = 1
    assert @backer.valid?, @backer.errors.full_messages
    @backer.backing_amount = '.01'
    assert @backer.valid?, @backer.errors.full_messages
    @backer.backing_amount = 1.01
    assert @backer.valid?, @backer.errors.full_messages
  end

  test 'Backing dollar amounts should NOT use the $ currency symbol to avoid issues with shell escaping.' do
    @backer.backing_amount = '$1.99'
    assert_not @backer.valid?, @backer.errors.full_messages
  end
end
