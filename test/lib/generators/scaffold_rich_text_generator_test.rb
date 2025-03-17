require "test_helper"
require "generators/scaffold_rich_text/scaffold_rich_text_generator"

class ScaffoldRichTextGeneratorTest < Rails::Generators::TestCase
  tests ScaffoldRichTextGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
