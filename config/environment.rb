# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Anithre::Application.initialize!

# Initialize the Amazon Product Advertising API.
aws_config = YAML.load(ERB.new(File.read("#{Rails.root.to_s}/config/aws.yml")).result)[Rails.env]
Amazon::Ecs.options = {
  associate_tag: aws_config["associate_tag"],
  AWS_access_key_id: aws_config["AWS_access_key_id"],
  AWS_secret_key: aws_config["AWS_secret_key"],
  country: "jp"
}
