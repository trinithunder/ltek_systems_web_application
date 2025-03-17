require "test_helper"
require "generators/lte5g_vpn/lte5g_vpn_generator"

class Lte5gVpnGeneratorTest < Rails::Generators::TestCase
  tests Lte5gVpnGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
