require "test_helper"
require "generators/themeable_install/themeable_install_generator"

class ThemeableInstallGeneratorTest < Rails::Generators::TestCase
  tests ThemeableInstallGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
