require "test_helper"
require "generators/email_setup/email_setup_generator"

class EmailSetupGeneratorTest < Rails::Generators::TestCase
  tests EmailSetupGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
