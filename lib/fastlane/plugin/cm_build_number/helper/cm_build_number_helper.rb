require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class CmBuildNumberHelper
      # class methods that you define here become available in your action
      # as `Helper::CmBuildNumberHelper.your_method`
      #
      def self.cook_humanable(date = nil, format:)
        date ||= Time.now
        date = DateTime.parse(date) if date.kind_of?String
        build_number = date.strftime(format)

        Actions.lane_context[Actions::SharedValues::HUMANABLE_BUILD_NUMBER] = build_number
        ENV[Actions::SharedValues::HUMANABLE_BUILD_NUMBER.to_s] = build_number
      end

      def self.ios_project?
        ['*.xcodeproj', '*.xcworkspace'].each do |pattern|
          if Dir.glob(pattern).size > 0
            return true
          end
        end

        false
      end

      def self.android_project?
        Dir.glob("*gradle*").size > 0 ? true : false
      end

      def self.set_build_number_for_android_tips
        division_count = 50
        [
          'Here is a example to follow to set build number with gradle:',
          '-' * division_count,
          'lane :set_build_number do',
          '  gradle(',
          '    task: "assemble", ',
          '    build_type: "debug", ',
          '    properties: { ',
          '      "versionCode" => humanable_build_number.to_i',
          '    }',
          '  )',
          'end',
          '-' * division_count
        ].join("\n")
      end
      def self.show_message
        UI.message("Hello from the cm_build_number plugin helper!")
      end
    end
  end
end
