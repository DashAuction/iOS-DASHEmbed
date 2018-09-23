#
# Be sure to run `pod lib lint DASHEmbed.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DASHEmbed'
  s.version          = '1.1.0'
  s.summary          = 'An easy way to embed DASH into an iOS app'

  s.description      = <<-DESC
DASHEmbed provides an easy way to embed the DASH mobile experience into an iOS application.
                       DESC

  s.homepage         = 'https://github.com/DashAuction/iOS-DASHEmbed'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'DASH' => 'ryan@dashapp.io' }
  s.source           = { :git => 'https://github.com/DashAuction/iOS-DASHEmbed.git', :tag => s.version.to_s }

  s.swift_version = '4.0'
  s.ios.deployment_target = '10.0'
  s.source_files = 'DASHEmbed/Framework/**/*.{swift}'
  s.resource_bundles = {
  'DASHEmbed' => ['DASHEmbed/Framework/**/*.{storyboard,xib}']
  }
  s.frameworks = 'Foundation', 'UIKit', 'UserNotifications', 'WebKit'
end
