require_relative "../spec_helper.rb"

RSpec.describe "This buildpack" do
  it "has its own tests" do
    # Specify where you want your buildpack to go using :default
    buildpacks = [:default, "heroku/ruby"]

    # To deploy a different app modify the hatchet.json or
    # commit an app to your source control and use a path
    # instead of "default_ruby" here
    Hatchet::Runner.new("default_ruby", buildpacks: buildpacks).tap do |app|
      app.before_deploy do
        # Modfiy the app here if you need
      end
      app.deploy do
        # Assert the behavior you desire here
        expect(app.output).to match("deployed to Heroku")

        expect(app.run("which ffmpeg").strip).to match("/app/.heroku/activestorage-preview/bin/ffmpeg")
        expect(app.run("which pdftoppm").strip).to match("/app/.heroku/activestorage-preview/bin/usr/pdftoppm")
      end
    end
  end
end
