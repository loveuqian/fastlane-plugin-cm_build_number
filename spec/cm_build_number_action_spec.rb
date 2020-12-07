describe Fastlane::Actions::CmBuildNumberAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The cm_build_number plugin is working!")

      Fastlane::Actions::CmBuildNumberAction.run(nil)
    end
  end
end
