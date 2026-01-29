#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint prevent_app_screen.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'prevent_app_screen'
  s.version          = '0.1.1'
  s.summary          = 'A Flutter plugin to prevent screenshots and screen recordings.'
  s.description      = <<-DESC
A Flutter plugin to prevent screenshots and screen recordings on Android, iOS, macOS, Windows, Linux, and Web.
                       DESC
  s.homepage         = 'https://github.com/Mahmoud-t0lba/screen_shot'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mahmoud Tolba' => 'mahmoudt0lba0111@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
