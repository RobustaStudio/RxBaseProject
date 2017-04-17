#
# Be sure to run `pod lib lint RxBaseProject.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxBaseProject'
  s.version          = '0.1.0'
  s.summary          = 'RxBaseProject is a kickstarting project for RxApplications'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
RxBaseProject is a kickstarting project for RxApplications, no need to keep repeating the code over and over again
                       DESC

  s.homepage         = 'http://gitlab.robustastudio.com/ios/RxBaseProject'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ahmed93' => 'ahmed.moh.magdi93@gmail.com' }
  s.source           = { :git => 'gitlab@gitlab.robustastudio.com:ios/RxBaseProject.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'RxBaseProject/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RxBaseProject' => ['RxBaseProject/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'

    s.subspec 'Core' do |ss|
    ss.dependency 'RxSwift', '~> 3.3.1'
    ss.dependency 'RxCocoa', '~> 3.3.1'
    
  end
  
  s.subspec 'Networking' do |ss|
    ss.dependency 'Moya-ObjectMapper/RxSwift' #, :git => 'https://github.com/ivanbruel/Moya-ObjectMapper'
    ss.dependency 'Moya', '~> 8.0.3'
    ss.dependency 'Alamofire' , '~>4.4.0'
    ss.dependency 'ReachabilitySwift', '~> 3.0.0'
    ss.dependency 'Result' , '~> 3.2.1'
  end

  s.subspec 'Extra-Kit' do |ss|
    ss.dependency 'DZNEmptyDataSet' , '~>1.8.1'
    ss.dependency 'Kingfisher' , '~> 3.6.1'
    ss.dependency 'ReusableKit' , '~> 1.1.0'
    ss.dependency 'RxDataSources' , '~>1.0.3'
    ss.dependency 'RxGesture' , '~> 1.0.0'
    ss.dependency 'RxKeyboard' , '~>0.4.1'
    ss.dependency 'RxOptional' , '~>3.1.3'
    ss.dependency 'SVProgressHUD', '~>2.1.2'
    ss.dependency 'SnapKit', '~>3.2.0'
    ss.dependency 'SwiftMessages', '~> 3.3.3'
    ss.dependency 'Then', '~>2.1.0'
  end
end
