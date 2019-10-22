Pod::Spec.new do |s|

  s.name         = "SwiftEntryKitModality"
  s.version      = "0.0.1"
  s.description  = "SwiftEntryKitModality framework"
  s.summary      = "SwiftEntryKitModality framework help with modal view. Written in Swift."
  s.platform     = :ios
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.requires_arc = true

  s.homepage     = "https://github.com/DimaIgorevich/ReachableObserver"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Dmitriy" => "dzhimasan@gmail.com" }
  s.source       = { :git => "https://github.com/DimaIgorevich/SwiftEntryKitModality.git", :tag => "#{s.version}" }
  s.source_files = 'SwiftEntryKitModality/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'SwiftEntryKit', '0.8.9'

end