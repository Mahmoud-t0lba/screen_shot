#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint prevent_app_screen.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'prevent_app_screen'
  s.version          = '0.1.2'
  s.summary          = 'A Flutter plugin to prevent screenshots and screen recordings.'
  s.description      = <<-DESC
A Flutter plugin to prevent screenshots and screen recordings on Android, iOS, macOS, Windows, Linux, and Web.
                       DESC
  s.homepage         = 'https://github.com/Mahmoud-t0lba/screen_shot'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mahmoud Tolba' => 'mahmoudt0lba0111@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files = 'prevent_app_screen/Sources/prevent_app_screen/**/*'

  # If your plugin requires a privacy manifest, for example if it collects user
  # data, update the PrivacyInfo.xcprivacy file to describe your plugin's
  # privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  s.resource_bundles = {'prevent_app_screen_privacy' => ['prevent_app_screen/Sources/prevent_app_screen/Resources/PrivacyInfo.xcprivacy']}

  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
