require "test_helper"
require "generators/apache_vhost/apache_vhost_generator"

class ApacheVhostGeneratorTest < Rails::Generators::TestCase
  tests ApacheVhostGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
