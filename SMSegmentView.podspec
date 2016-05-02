Pod::Spec.new do |s|

  s.name         = "SMSegmentView"
  s.version      = "1.2.0"
  s.summary      = "Custom segmented control for iOS 7 and above"

  s.description  = <<-DESC
                   Written in Swift.
                   Support both images and text.
                   Support vertically organise segments
                   More customisible than UISegmentedControl and easier to expand with new style.
                   DESC

  s.homepage     = "https://github.com/allenbryan11/SMSegmentView"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author       = "allenbryan11"
  s.platform     = :ios, "7.0"

  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/allenbryan11/SMSegmentView.git", :branch => "master" }


  s.source_files  = "SMSegmentViewController/SMSegmentView/*.swift"
  s.requires_arc = true
  s.frameworks = 'UIKit'

end
