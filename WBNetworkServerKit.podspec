#
# Be sure to run `pod lib lint NetworkServerKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WBNetworkServerKit'
  s.version          = '0.2.0'
  s.summary          = '一个简单的网络请求库.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
方便集成和使用网络请求框架.
                       DESC

  s.homepage         = 'https://github.com/wqq1991/NetworkKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '桥桥 吴' => 'wqq1991@live.com' }
  s.source           = { :git => 'https://github.com/wqq1991/NetworkKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'WBNetworkServerKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NetworkServerKit' => ['NetworkServerKit/Assets/*.png']
  # }

  # s.public_header_files = 'WBNetworkServerKit/Classes/**/*.swift'
  # s.frameworks = 'UIKit', 'MapKit' 
  s.dependency 'Alamofire'
  s.dependency 'Moya'
  
  #JSON解析
  s.dependency 'HandyJSON'
end
