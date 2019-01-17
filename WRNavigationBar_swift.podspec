Pod::Spec.new do |s|
  s.name             = 'WRNavigationBar_swift'
  s.version          = '0.1.0'
  s.summary          = 'A useful custom navigation bar.'

  s.description      = <<-DESC
WRNavigationBar which allows you to change NavigationBar's appearance dynamically.
                       DESC

  s.homepage         = 'https://github.com/wangrui460/WRNavigationBar_swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangrui460' => 'wangruidev@gmail.com' }
  s.source           = { :git => 'https://github.com/wangrui460/WRNavigationBar_swift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = "4.2"
  s.ios.deployment_target = '8.0'

  s.source_files = 'WRNavigationBar_swift/Classes/**/*'
end
