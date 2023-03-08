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
        FileUtils.cp(fixtures.join("flashlight.mp4"), "./flashlight.mp4")
      end
      app.deploy do
        # Assert the behavior you desire here
        expect(app.output).to match("deployed to Heroku")

        expect(app.run("which ffmpeg").strip).to match("/app/.heroku/activestorage-preview/bin/ffmpeg")
        expect(app.run("which pdftoppm").strip).to match("/app/.heroku/activestorage-preview/usr/bin/pdftoppm")

        expect(app.run("ffprobe ./flashlight.mp4").strip).to include("Duration: 00:00:04.44")
        expect(app.run("pdftoppm -v").strip).to include("pdftoppm version")
      end
    end
  end
end
