require_relative "../spec_helper.rb"

RSpec.describe "This buildpack" do
  it "has its own tests" do
    # Specify where you want your buildpack to go using :default
    buildpacks = [:default]

    new_app_with_stack("spec/fixtures/", buildpacks: buildpacks).tap do |app|
      app.deploy do
        # Assert the behavior you desire here
        expect(app.output).to match("deployed to Heroku")

        expect(app.run("which ffmpeg").strip).to match("/app/.heroku/activestorage-preview/bin/ffmpeg")

        expect(app.run("ffprobe ./flashlight.mp4").strip).to include("Duration: 00:00:04.44")
      end
    end
  end
end
