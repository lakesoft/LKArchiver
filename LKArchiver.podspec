Pod::Spec.new do |s|
  s.name         = "LKArchiver"
  s.version      = "1.3.1"
  s.summary      = "NSKeyedArchiver/NSKeyedUnArchiver wrapper"
  s.description  = <<-DESC
NSKeyedArchiver/NSKeyedUnArchiver wrapper.
                   DESC
  s.homepage     = "https://github.com/lakesoft/LKArchiver"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Hiroshi Hashiguchi" => "xcatsan@mac.com" }
  s.source       = { :git => "https://github.com/lakesoft/LKArchiver.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/*'

end
