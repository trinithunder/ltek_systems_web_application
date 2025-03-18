require "test_helper"
require "generators/nevaeh/nevaeh_generator"

class NevaehGeneratorTest < Rails::Generators::TestCase
  tests NevaehGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
