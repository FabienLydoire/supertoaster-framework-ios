
Pod::Spec.new do |s|

  s.name         = "STFramework"
  s.version      = "0.0.1"
  s.summary      = "A collection of tools and helper classes for iOS projects"
  s.description  = "A collection of tools and helper classes for iOS projects"

  s.homepage     = "https://github.com/supertoasteragency/supertoaster-framework-ios"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Louis de Decker" => "louis@supertoaster.be" }
  s.platform     = :ios, "8.4"
  s.source       = { :git => "https://github.com/supertoasteragency/supertoaster-framework-ios.git", :tag => "#{s.version}" }
  s.source_files  = "STFramework/**/*.{h,m}"
#s.resources = "STFramework/**/*.{png,jpeg,jpg,storyboard,xib}"
  s.requires_arc = true
  s.framework = "UIKit"
end
