Pod::Spec.new do |s|

  s.name         = "SwiftEntryKitModality"
  s.version      = "0.0.1"
  s.summary      = "SwiftEntryKitModality framework help with modal view. Written in Swift."
  s.platform     = :ios
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.requires_arc = true

  s.description      = <<-DESC
SwiftEntryKit is a banner presenter library for iOS. It can be used to easily display pop-ups and notification-like views within your iOS apps. SwiftEntryKit is highly customizable but also offers a bunch of beautiful presets that can be themed with your app fonts and colors.
DESC
  s.homepage     = "https://github.com/DimaIgorevich/ReachableObserver"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Dmitriy" => "dzhimasan@gmail.com" }
  s.source       = { :git => "https://github.com/DimaIgorevich/SwiftEntryKitModality.git", :tag => "#{s.version}" }
  s.source_files = 'Source/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'QuickLayout', '0.8.9'

end